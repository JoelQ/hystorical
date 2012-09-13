module Hystorical
  class ARRelation

    def self.current(collection)
      collection.where(end_date: nil)
    end

    def self.current_on(collection, date)
      collection.where("? BETWEEN start_date AND end_date", date)
    end
  end
end
