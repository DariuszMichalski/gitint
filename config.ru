$LOAD_PATH << File.join(Dir.getwd, "/lib")

require 'rubygems'
require 'bundler'

Bundler.require

set :environment, :development

require './api'

run API


