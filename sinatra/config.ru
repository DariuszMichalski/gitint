require 'rubygems'
require 'bundler'

Bundler.require

set :environment, :development

require './api'

run API


