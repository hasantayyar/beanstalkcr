**Warning** This project is under development and not finished. All contributions or suggestions are welcome. 

Beanstalk Client for Crystal
========================

A [Beanstalkd](http://kr.github.io/beanstalkd/) client for the [Crystal](http://crystal-lang.org)


## Usage

```crystal
require "./beanstalkcr/src"

beanstalk = Beanstalk.new
beanstalk.put("foo")
```
