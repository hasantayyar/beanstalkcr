require "./src/*"

beanstalk = Beanstalk.new(host: "localhost", port: 11300)
puts "using demo"
# beanstalk.use("demo")
# puts "put a job `foo`"
# beanstalk.put("foo")
puts "reserve a job"
s = beanstalk.reserve
# puts s
