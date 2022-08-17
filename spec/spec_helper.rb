require 'rubygems'
require 'bundler/setup'

require 'mongoid'
require 'rspec'

require 'arraylist'

# Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Mongoid.configure do |config|
  name = "mongoid_arraylist_test"
  config.respond_to?(:connect_to) ? config.connect_to(name) : config.master = Mongo::Connection.new.db(name)
end

RSpec.configure do |config|
  # Clean up the database
  require "database_cleaner/mongoid"
  DatabaseCleaner[:mongoid].strategy = [:deletion]

  RSpec.configure do |c|
    c.before(:each) { DatabaseCleaner.clean }
  end
end
