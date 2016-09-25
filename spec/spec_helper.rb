require 'rack/test'
require 'rspec'
require File.expand_path('../../config/environment.rb', __FILE__)

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app() described_class end
end

RSpec.configure do |c|
  c.include RSpecMixin
  c.before(:all) do
    Task.destroy_all
  end
  c.after(:each) do
    Task.destroy_all
  end
end
