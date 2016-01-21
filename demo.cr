require "./src/*"

beanstalk = Beanstalk.new(host: "localhost", port: 11300)
beanstalk.use("demo")
o = beanstalk.put("foo")
puts o
