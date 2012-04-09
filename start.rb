#!/usr/bin/ruby
require 'rubygems'
require 'daemons'

pwd = Dir.pwd
Daemons.run_proc('main.rb', {:dir_mode => :normal, :dir => "/opt/pids/sinatra"}) do
Dir.chdir(pwd)
exec "ruby main.rb"
end
