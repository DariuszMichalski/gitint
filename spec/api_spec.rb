require 'spec_helper'

set :environment, :test

describe "API" do
  it "should load the home page" do
    get "/"
    last_response.status.should == 200
  end
end

describe "Commit Parser" do
 # moved to snd_commit_parser.rb
end

