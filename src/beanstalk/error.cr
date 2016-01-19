class Beanstalk::Error < Exception
  def initialize(s)
    super("BeanstalkError: #{s}")
  end
end
