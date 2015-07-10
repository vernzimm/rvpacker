require 'bundler/gem_tasks'
require 'rake/clean'
require 'yard'

CLEAN.include(Dir['**/*'] - `git ls-files`.split("\n"))
Rake::Task['clobber'].clear

YARD::Rake::YardocTask.new do |yard|
  yard.options = [
    '--title', 'rvpacker Documentation',
    '--readme', 'README.md',
    '--files', 'LICENSE',
    '--markup', 'markdown'
  ]
end

namespace :yard do
  desc 'Remove YARD Documentation'
  task :clean do
    rm_r('doc/') if File.directory?('doc/')
  end

  desc 'Start YARD Documentation server on localhost:8808'
  task :serve do
    sh 'yard server -r'
  end
end

task :clean => 'yard:clean'
task :default => :yard
