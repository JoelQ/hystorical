require 'hystorical/ruby_collection'
require 'hystorical/ar_relation'
module Hystorical

  def self.delegate_class(collection)
    if collection.class == ActiveRecord::Relation
      return Hystorical::ARRelation
    else
      return Hystorical::RubyCollection
    end
  end

  def self.current(collection)
    delegate_class(collection).current(collection)
  end

  def self.current_on(collection, date)
    delegate_class(collection).current_on(collection, date)
  end
end
