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
  end

  post '/project/:project_id' do # github-services
    # puts "\n* Got POST message from github-services * project_id: #{params[:project_id]}"
    # puts "\nJSON:\n" + params[:data]
    # puts "\nParsed:\n" + JSON.parse(params[:data]).inspect
    
    if params[:project_id] and data = JSON.parse(params[:data]) and data_correct?(data)
      last_commit = data["payload"]["commits"].last # get last commit 
      # parse commit message
      cp = CommitParser.new(last_commit)
      # this is just for testing
      status 200
      # puts cp.to_json
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


