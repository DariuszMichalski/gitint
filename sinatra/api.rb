class API < Sinatra::Base

  # --------- application config block --------- #
  configure do
    set :root, File.dirname(__FILE__)
  end
  configure :development do
    set :database => "sqlite://gitint-dev.db"
  end
  configure :test do
    set :database => "sqlite://gitint-test.db"
  end
  # -------------------------------------------- #

  get '/' do
    "Hello World!"
  end

  post '/push' do
    push = JSON.parse(params[:payload])
    puts push.inspect
  end

end


