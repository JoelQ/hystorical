module Hystorical
  class RubyCollection
    class << self

      def current(collection)
        collection.select { |obj| obj.respond_to?(:[]) ? obj[:end_date].nil? : obj.end_date.nil? }
      end

      def current_on(collection, date)
        collection.select do |obj|
          if obj.respond_to?(:[])
            obj[:start_date] <= date && obj[:end_date] >= date
          else
            obj.start_date <= date && obj.end_date >= date
          end
        end
      end
    end
  end
end
