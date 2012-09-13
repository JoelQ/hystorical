class RubyHystorical

  def self.current(collection)
    collection.select { |obj| obj[:end_date].nil? }
  end
end