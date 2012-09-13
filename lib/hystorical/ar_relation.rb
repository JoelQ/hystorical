module Hystorical
  class ARRelation
    class << self
      def current(collection)
        collection.where(end_date: nil)
      end

      def current_on(collection, date)
        collection.where("? BETWEEN start_date AND end_date", date)
      end
    end
  end
end
