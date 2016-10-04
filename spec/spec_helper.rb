require 'rack/test'
require 'rspec'
require File.expand_path('../../config/environment.rb', __FILE__)

ENV['RACK_ENV'] = 'test'

RSpec.configure do |c|
  c.before(:all) do
    Task.destroy_all
  end
  c.after(:each) do
    Task.destroy_all
  end
end
