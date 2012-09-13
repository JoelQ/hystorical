class RubyHystorical

  def self.current(collection)
    collection.select { |obj| obj.respond_to?(:[]) ? obj[:end_date].nil? : obj.end_date.nil? }
  end

  def self.current_on(collection, date)
    collection.select do |obj|
      if obj.respond_to?(:[])
        obj[:start_date] <= date && obj[:end_date] >= date
      else
        obj.start_date <= date && obj.end_date >= date
      end
    end
  end
end