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
    def data_correct?(data)
      data["token"] && data["payload"] && data["payload"]["commits"]
    rescue
      false
    end
  end

  get '/' do
    status 200
    # parse sample commit message
    cp = CommitParser.new("[ In Progress  #321] my commit message")  #(last_commit_message)
  end

  post '/project/:project_id' do # github-services
    # puts "\n* Got POST message from github-services * project_id: #{params[:project_id]}"
    # puts "\nJSON:\n" + params[:data]
    # puts "\nParsed:\n" + JSON.parse(params[:data]).inspect

    if params[:project_id] and data = JSON.parse(params[:data]) and data_correct?(data)
      last_commit_message = data["payload"]["commits"].last["message"] # get last commit message
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

  post '/push' do
    # payload = JSON.parse(params[:payload])
    # puts "payload: #{payload}"
    status 200
  end

end


