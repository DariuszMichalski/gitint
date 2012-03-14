require 'spec_helper'

set :environment, :test

describe "API" do
  it "should load the home page" do
    get "/"
    puts last_response.body
    last_response.status.should == 200
    last_response.body.should == 'Hello World!'
  end
end

describe "Commit Parser" do
  before(:each) do
    @github_hook = {
      :commits => [
        {:message => "first commit message", :committer => {:name => "name of a person", :username => "Username", :email => "some@email.com"}},
        {:message => "[ In Progress #123] Last commit message", :committer => {:name => "name of a person", :username => "Username", :email => "some@example.com"}},
      ]
    }
  end

  it "should get POST payload from gihub and return parsed data" do
    post "/push", params = {:payload => @github_hook.to_json}
    parsed_data = {:complete_message => "[ In Progress #123] Last commit message",
                   :commit_message   => "Last commit message",
                   :stories          => ["#123"],
                   :workflow_changes => {"#123" => "In Progress"} }
    last_response.status.should == 200
    last_response.body.should == parsed_data.to_json
  end

end

