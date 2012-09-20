module Hystorical
  class ARRelation
    class << self
      def current(collection)
        current_items = collection.where(end_date: nil)
        block_given? ? current_items.select { |item| yield item } : current_items
      end

      def current_on(collection, date)
        current_items = collection.where("? BETWEEN start_date AND end_date", date)
        block_given? ? current_items.select { |item| yield item } : current_items
      end
    end
  end
end
