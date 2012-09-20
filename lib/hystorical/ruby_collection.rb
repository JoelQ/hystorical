module Hystorical
  class RubyCollection
    class << self

      def current(collection)
        collection.select do |obj|
          current = get_attr(obj, :end_date).nil?
          block_given? ? (yield obj) && current : current
        end
      end

      def current_on(collection, date)
        collection.select do |obj|
          current = (get_attr(obj, :start_date) <= date) && (get_attr(obj, :end_date) >= date)
          block_given? ? (yield obj) && current : current
        end
      end

      private
      def get_attr(obj, attribute)
        obj.respond_to?(:[]) ? obj[attribute] : obj.send(attribute)
      end

    end
  end
end
