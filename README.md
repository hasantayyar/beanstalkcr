**Warning** This project is my first project with crystal to understand the basics of crystal and still under development.All contributions or suggestions are welcome. 

Beanstalk Client for Crystal
========================

A [Beanstalkd](http://kr.github.io/beanstalkd/) client for the [Crystal](http://crystal-lang.org)


## Usage

```crystal
require "./beanstalkcr/src"

beanstalk = Beanstalk.new
beanstalk.put("foo")
```
