require 'hystorical/ruby_collection'
require 'hystorical/ar_relation'
module Hystorical

  def self.delegate_class(collection)
    if collection.class == ActiveRecord::Relation
      Hystorical::ARRelation
    else
      Hystorical::RubyCollection
    end
  end

  def self.current(collection)
    delegate_class.current(collection)
  end

  def self.current_on(collection, date)
    delegate_class.current_on(collection, date)
  end
end
