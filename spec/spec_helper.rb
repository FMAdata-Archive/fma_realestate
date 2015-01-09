$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec'
require 'fma_realestate'

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.include RequestFixturesHelper

  config.before(:all) do
    Excon.defaults[:mock] = true
  end

  config.after(:each) do
    Excon.stubs.clear
  end
end
