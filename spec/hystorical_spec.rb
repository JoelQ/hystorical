describe Hystorical do

  describe ".delegate_class" do
    it "should return RubyHystorical" do
      Hystorical.delegate_class.should be RubyHystorical
    end
  end
end