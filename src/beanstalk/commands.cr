class Beanstalk
  #
  module Commands
    # Put new job
    # Example:
    #
    # ```
    # beanstalk.put("foo")
    # ```
    def put(body, priority = 2147483648, delay = 0, ttr = 120)
      # put %d %d %d %d\r\n%s\r\n' % ( priority, delay, ttr, len(body), body)
      q = ["put ", priority.to_s + " "]
      q << delay.to_s + " " if delay
      q << ttr.to_s + " " if ttr
      q << body.size.to_s
      q << "\r\n"
      q << body.to_s
      q << "\r\n"
      s = q.join("")
      s_command(s)
    end

    def stats
      s_command("stats")
    end

    # Use tube
    # Example:
    #
    # ```
    # beanstalk.use("foo-tube")
    # ```
    def use(name)
      s_command("use " + name.to_s)
    end

    def quit
      s_command(["QUIT"])
    end
  end
end
