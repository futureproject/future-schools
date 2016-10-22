ENV["RACK_ENV"] = "test"
ENV["SESSION_SECRET"] ||= "12345"
require "pry"
require "capybara"
require "capybara/rspec"
require "capybara/dsl"
require_relative "../main"
Dir["#{App.root}/spec/support/*.rb"].each {|f| require f }

Capybara.app = Rack::Builder.parse_file(File.expand_path('../../config.ru', __FILE__)).first

Capybara.default_selector = :css
#Capybara.javascript_driver = :webkit
#Capybara.default_driver = :webkit

RSpec.configure do |config|
  config.color = true
  App.cache.flush
end

def stub_airtable_response!(url, response, method=:get)
  FakeWeb.register_uri(
    method,
    url,
    body: response.to_json,
    content_type: "application/json"
  )
end
