require 'rubygems'
require 'bundler/setup'
require 'tempfile'
require 'minitest/autorun'
require 'minitest/reporters'
require 'mocha/setup'
require 'stringio'
require 'json'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'sshkit'
require 'sshkit-backend-docker'

Dir[File.expand_path('test/support/*.rb')].each { |file| require file }

class UnitTest < Minitest::Test
  def setup
    SSHKit.reset_configuration!
    SSHKit.config.backend = SSHKit::Backend::Docker
  end

  SSHKit::Backend::ConnectionPool.class_eval do
    alias_method :old_flush_connections, :flush_connections
    def flush_connections
      Thread.current[:sshkit_pool] = {}
    end
  end
end

#
# Force colours in Autotest
#
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

