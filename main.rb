#!/usr/bin/env ruby
require 'rubygems'
require 'active_record'
require 'sinatra'

$config = YAML.load_file(File.join(File.dirname(__FILE__), 'db.yml'))
set :bind, '0.0.0.0'

class Zrecipes < ActiveRecord::Base
  establish_connection $config['database_1']
  self.primary_key = 'Z_PK'
end

before do
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With"
end

load 'routes.rb'
