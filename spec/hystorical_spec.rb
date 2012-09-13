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
end