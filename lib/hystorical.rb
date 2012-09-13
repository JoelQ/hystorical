require 'hystorical/ruby_collection'
require 'hystorical/ar_relation'
module Hystorical

  def self.delegate_class
    Hystorical::RubyCollection
    # add conditional to determine which subclass to use once other strategies are used (i.e. ActiveRecord)
  end

  def self.current(collection)
    delegate_class.current(collection)
  end

  def self.current_on(collection, date)
    delegate_class.current_on(collection, date)
  end
end
