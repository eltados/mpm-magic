require 'rubygems'
require 'require_all'
require 'rake/testtask'
require 'sinatra/activerecord/rake'
require './sinatra.rb'

Rake::TestTask.new do |t|
  t.libs << "tests"
  t.test_files = FileList['tests/**/*_test.rb']
end
