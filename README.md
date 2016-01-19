**Warning** This project is under development and not finished. All contributions or suggestions are welcome. 

Beanstalk Client for Crystal
========================

A [Beanstalkd](http://kr.github.io/beanstalkd/) client for the [Crystal](http://crystal-lang.org)


## Usage

```crystal
require "beanstalk"

beanstalk = Beanstalk.new
beanstalk.put("foo")



## Installation

```crystal
dependencies:
  beanstalk:
    github: hasantayyar/beanstalkcr
    version: ~> 0.0.1
```

and then install the library into your project:

```bash
$ crystal deps
```


## Required Crystal Version
