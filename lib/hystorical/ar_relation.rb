module Hystorical
  class ARRelation
    def self.current(collection)
      collection.where(end_date: nil)
    end
  end
end
