# SSHKit::Backend::Docker

Docker connector backend for SSHKit.
You can execute commands inside docker container without ssh connection.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sshkit-backend-docker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sshkit-backend-docker

## Usage

**If you use capistrano, please refer [capistrano-deploy_into_docker](https://github.com/sugi/capistrano-deploy_into_docker).**

Currently, you need to set `SSHKit.config.backend` to run command with docker backend.

```ruby
SSHKit.config.backend = SSHKit::Backend::Docker
```

### Host definitions

`SSHKit::Backend::Docker` extends `SSHKit::Host`.
You can specify docker environemnt as Hash. The hash requires `:image` (or :container) key to run.

```ruby
host = SSHKit::Host.new(docker: {image: 'ruby:slim'})
```

In addtion, you can add any options for "docker run" via docker_run_image. for example;

```ruby
host = SSHKit::Host.new(docker: {
    image: 'sugi/rails-base:latest',
    commit: 'new-image-name:tag',
    volume: ['/storage/tmp:/tmp', '/storage/home:/home'],
    network: 'my-net',
    dns: '8.8.8.8',
    dns_search: 'example.com',
    cap_add: ['SYS_NICE', 'SYS_RESOURCE'],
  }, user: 'nobody:nogroup')
```

### DSL

* `docker_commit` - Commit running container as image. In default `:commit` key of host will be used. You can pass argument to override. Currently this DSL method can commit container *which is ran by SSHKit::Backend::Docker from image*.
* `docker_run_image` - In useal case, Docker container will start automatically when execute command. However you can run any image intentionally by `docker_run_iamge`.

### Examples

```ruby
require 'sshkit'
require 'sshkit-backend-docker'
include SSHKit::DSL

SSHKit.config.backend = SSHKit::Backend::Docker

host = {docker: {image: 'ruby:slim'}}

on [host] do
   execute :ls
   upload! '/etc/passwd', '/etc/passwd'
   docker_commit 'my-new-image'
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sugi/sshkit-backend-docker.

## Copyright

2016 Tatsuki Sugiura, this library is distributed [MIT License](https://opensource.org/licenses/MIT).

