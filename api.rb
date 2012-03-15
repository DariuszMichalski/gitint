require 'sinatra'
require 'json'
require 'commit_parser'

class API < Sinatra::Base

  # --------- application config block --------- #
  configure do
    set :root, File.dirname(__FILE__)
  end
  # -------------------------------------------- #

  helpers do
    def payload_correct?(payload)
      payload["token"] && payload["project_id"] && payload["commit"]["message"] &&
        payload["github_user"]["username"] && payload["github_user"]["email"]
    rescue
      false
    end
  end

  get '/' do
    status 200
    # parse sample commit message
    cp = CommitParser.new("[ In Progress  #321] my commit message")  #(last_commit_message)
  end

  post '/push' do
    if push = JSON.parse(params[:payload]) and payload_correct?(push)
      last_commit_message = push["commit"]["message"] # get last commit message
      # parse commit message
      cp = CommitParser.new(last_commit_message)
      # this is just for testing
      status 200
      content_type :json
      cp.to_json # return object attributes as hash (for rspec tests)
    else
      status 400 # incorrect payload
    end

  end

end


