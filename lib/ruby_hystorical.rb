class RubyHystorical

  def self.current(collection)
    collection.select { |obj| obj.respond_to?(:[]) ? obj[:end_date].nil? : obj.end_date.nil? }
  end
end