require "sinatra/base"
require "bundler/setup"

class App < Sinatra::Base
  Bundler.require(:default, settings.environment)

  # load Environment variables
  # (foreman handles ENV variables in production)
  configure :test, :development do
    Dotenv.load
  end

  require "sinatra/json"

  configure do
    #use Rack::Session::Cookie, expire_after: 259200, secret: ENV["SESSION_SECRET"]
    use Rack::Cache
    use Rack::Deflater
    enable :logging
    # start memecache
    set :cache, Dalli::Client.new
  end

  configure :production do
    # cache static assets agressively, because
    # Sprockets uses digests to guarantee unique filenames
    set :static_cache_control, [:public, :max_age => 31536000]
  end

  configure :development, :test do
    # debug modules, move to next group if you need them while running tests
    Dir["#{settings.root}/debug/*.rb"].each{|f| require f}
  end


  # all the good stuff
  Dir["#{settings.root}/{lib,helpers,models}/*.rb"].each{|f| require f}

  require "./assets/init"

end

class ApplicationController < App
  Dir["#{settings.root}/controllers/*.rb"].each{|f| require f}
end

