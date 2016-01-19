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
    line = get_line
    len = line.to_i
    return nil if len == -1
    bulk_string = String.new(len) do |buff|
      @socket.read_fully(Slice.new(buff, len))
      {len, 0}
    end
    # Ignore CR/LF
    @socket.skip(2)
    bulk_string
    # if type == nil
    #  raise Beanstalk::Error.new("Received nil type string")
    # else
    #  raise Beanstalk::Error.new("Cannot parse response with type #{type}: #{line.inspect}")
    # end
    # raise Beanstalk::Error.new(line)
  end

  def get_line
    line = @socket.gets
    unless line
      raise Beanstalk::Error.new("Disconnected")
    end
    line.byte_slice(0, line.bytesize - 2)
  end
end
