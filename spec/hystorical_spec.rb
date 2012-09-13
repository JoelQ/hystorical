describe Hystorical do

  describe ".delegate_class" do
    it "should return RubyHystorical" do
      Hystorical.delegate_class.should be RubyHystorical
    end
  end

  describe ".current" do
    it "send current message to delegate class" do
      Hystorical.stub(:delegate_class).and_return(RubyHystorical)
      collection = stub
      RubyHystorical.should_receive(:current).with(collection)
      Hystorical.current(collection)
    end
  end

  describe ".current_on" do
    it "send current_on message to delegate class" do
      Hystorical.stub(:delegate_class).and_return(RubyHystorical)
      collection = stub
      date = stub
      RubyHystorical.should_receive(:current_on).with(collection, date)
      Hystorical.current_on(collection, date)
    end
  end
end