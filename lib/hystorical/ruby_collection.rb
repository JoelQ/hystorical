module Hystorical
  class RubyCollection
    class << self

      def current(collection)
        collection.select do |obj|
          current = end_date(obj).nil?
          block_given? ? (yield obj) && current : current
        end
      end

      def current_on(collection, date)
        collection.select do |obj|
          current = (start_date(obj) <= date) && (end_date(obj) >= date)
          block_given? ? (yield obj) && current : current
        end
      end

      private
      def start_date(obj)
        obj.respond_to?(:[]) ? obj[:start_date] : obj.start_date
      end

      def end_date(obj)
        obj.respond_to?(:[]) ? obj[:end_date] : obj.end_date
      end

    end
  end
end
