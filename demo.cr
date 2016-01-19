require "./src/*"

beanstalk = Beanstalk.new(host: "localhost", port: 11300)
#beanstalk.stats
beanstalk.put("foo")
