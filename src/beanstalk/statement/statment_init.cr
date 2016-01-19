class Beanstalk::Statement::Init < Beanstalk::Statement::Base
  def initialize(connection)
    @connection = connection
  end

  def command(request : Request)
    @connection.send(request)
    @connection.receive
  end
end
