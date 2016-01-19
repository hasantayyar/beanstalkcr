require "./beanstalk/commands"
require "./beanstalk/execute"

# **Usage*
#
# Require the package:
#
# ```crystal
# require "beanstalk"
# ```
#
# Then instantiate this client class:
#
# ```crystal
# beanstalk = Beanstalk.new
# ```
#
# Then you can call Beanstalk commands on the `beanstalk` object:
#
# ```crystal
# beanstalk.put("foo")
# ```
class Beanstalk
  # A Beanstalk request.
  # :nodoc:
  alias Request = String | Int32

  # Opens a Beanstalk connection
  #
  # **Options**:
  # * host - the host to connect to
  # * port - the port to connect to
  #
  # Example:
  #
  # ```
  # beanstalk = Beanstalk.new
  # beanstalk.put("job body")
  # beanstalk.close
  # ```
  #
  # Example:
  #
  # ```
  # beanstalk = Beanstalk.new(host: "localhost", port: 6379)
  # ...
  # ```

  def initialize(host = "localhost", port = 11300)
    @connection = Connection.new(host, port)
    @statement = Beanstalk::Statement::Init.new(@connection)
  end

  # Opens a Beanstalk connection, yields the given block with a Beanstalk object and closes the connection.
  #
  # **Options**:
  # * host - the host to connect to
  # * port - the port to connect to
  #
  # Example:
  #
  # ```
  # Beanstalk.open do |beanstalk|
  #   beanstalk.put("job body")
  # end
  # ```
  def self.use(tube = "default", port = 6379)
    beanstalk = Beanstalk.new(host, port)
    begin
      yield(beanstalk)
    ensure
      beanstalk.close
    end
  end

  # Most Beanstalk client API methods are defined in this module.
  include Beanstalk::Commands

  include Beanstalk::CommandExecution

  # This is an internal method.
  #
  # Executes a Beanstalk command.
  #
  # **Return value**: a BeanstalkValue (never a Future)

  # :nodoc:
  def command(request : Request)
    @statement.command(request) as Request
  end

  # Closes the Beanstalk connection.
  def close
    @connection.close
  end
end

require "./**"
