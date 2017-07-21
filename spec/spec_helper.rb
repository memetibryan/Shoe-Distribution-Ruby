ENV['RACK_ENV'] = 'test'

  require("bundler/setup")
  Bundler.require(:default, :test)
  set(:root, Dir.pwd())

  require('capybara/rspec')
  Capybara.app = Sinatra::Application
  set(:show_exceptions, false)
  require('./app')

  RSpec.configure do |config|
    config.after(:each) do
      Salon.all().each() do |salon|
        salon.destroy()
      end
      Client.all().each() do |client|
        client.destroy()
      end
    end
  end