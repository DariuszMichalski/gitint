require 'rack/test'
require 'spec/mocks'

begin
  require_relative '../api.rb'
rescue NameError
  require File.expand_path('../../api.rb', __FILE__)
end

module RSpecMixin
  include Rack::Test::Methods
  def app() API end
end

RSpec.configure { |c|
  c.include RSpecMixin
  c.mock_with :rspec
}
