$:.unshift File.expand_path("../../lib", __FILE__)

require 'date'
require 'sqlite3'
require 'active_record'
require 'with_model'
require "hystorical"

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database  => "test.db"
)

RSpec.configure do |config|
  config.extend WithModel
end
