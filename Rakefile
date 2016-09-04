require "bundler/gem_tasks"
require 'rake/testtask'
require 'rubocop/rake_task'
require 'rake/hooks'

task :default => [:test, :lint]

desc "Run all tests"
task :test => ['test:units', 'test:functional']

namespace :test do
  Rake::TestTask.new(:units) do |t|
    t.libs << "test"
    t.test_files = FileList['test/unit/**/test*.rb']
  end

  Rake::TestTask.new(:functional) do |t|
    t.libs << "test"
    t.test_files = FileList['test/functional/**/test*.rb']
  end
end

desc 'Run RuboCop lint checks'
RuboCop::RakeTask.new(:lint) do |task|
  task.options = ['--lint']
end

before :build do
  spec = Bundler.load_gemspec(File.join(File.dirname(__FILE__), 'sshkit-backend-docker.gemspec'))
  FileUtils.chmod(0644, spec.files)
end
