# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sshkit/backend/docker/version'

Gem::Specification.new do |spec|
  spec.name          = "sshkit-backend-docker"
  spec.version       = Sshkit::Backend::Docker::VERSION
  spec.authors       = ["Tatsuki Sugiura"]
  spec.email         = ["sugi@nemui.org"]

  spec.summary       = %q{Docker connector backend for SSHKit}
  spec.description   = %q{sshkit-backend-docker provides Docker connection and some utilities. You can execute commands inside docker container without ssh connection.}
  spec.homepage      = "http://github.com/sugi/sshki-backend-docker"

  spec.files         = Dir['lib/**/*.rb'] + %w(LICENSE README.md)
  #spec.bindir        = "exe"
  #spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 11.0"
  #spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-reporters"
end
