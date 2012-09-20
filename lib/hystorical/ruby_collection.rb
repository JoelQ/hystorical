module Hystorical
  class RubyCollection
    class << self

      def current(collection)
        collection.select do |obj|
          end_date(obj).nil?
        end
      end

      def current_on(collection, date)
        collection.select do |obj|
          start_date(obj) <= date && end_date(obj) >= date
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
