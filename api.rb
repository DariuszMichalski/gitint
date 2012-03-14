require 'sinatra'
require 'json'
require 'commit_parser'

class API < Sinatra::Base

  # --------- application config block --------- #
  configure do
    set :root, File.dirname(__FILE__)
  end

  # -------------------------------------------- #
  get '/' do
    status 200
    # parse sample commit message
    cp = CommitParser.new("[ In Progress  #321] my commit message")  #(last_commit_message)
    cp.parse
    "Hello World!"
  end

  post '/push' do
    push = JSON.parse(params[:payload]) # parse hook response
    last_commit_message = push["commits"].last["message"] # get last commit message
    committer = push["commits"].last["committer"] # get committer's data
    # print data from github
    puts "\nGithub Hook"
    puts last_commit_message.inspect
    puts committer.inspect
    # parse commit message
    cp = CommitParser.new(last_commit_message)
    cp.parse
    # this is just for testing
    status 200
    content_type :json
    cp.data_hash.to_json # return object attributes as hash (for rspec tests)
  end

end


