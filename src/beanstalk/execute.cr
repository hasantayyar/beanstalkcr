class Beanstalk
  module CommandExecution
    def s_command(request : Request) : String
      command(request) as String
    end
  end
end
