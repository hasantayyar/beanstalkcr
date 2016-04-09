require "socket"

# A connection to a Beanstalk instance.

class Beanstalk::Connection
  def initialize(host, port)
    @socket = TCPSocket.new(host, port)
    @socket.sync = false
    @connected = true
  end

  def finalize
    close
  end

  def close
    if @connected
      @socket.close
      @connected = false
    end
  end

  def send(request : Request)
    queue(request)
    flush
  end

  def queue(request : Request)
    marshal(request, @socket)
  end

  def flush
    @socket.flush
  end

  def marshal(arg : Int, io)
    io << ":" << arg << "\r\n"
  end

  def marshal(arg : String, io)
    io << arg << "\r\n"
  end

  def marshal(arg : Nil, io)
    io << "$-1\r\n"
  end

  def receive
    line = ""
    # get last line as output
    line1 = @socket.gets
    line2 = @socket.gets
    line = line2 != nil ? line2 : line1
    unless line
      raise Beanstalk::Error.new("Disconnected")
    end
    trimmed = line.byte_slice(0, line.bytesize - 2)
    # Ignore CR/LF
    @socket.skip(2)
    trimmed
  end
end
