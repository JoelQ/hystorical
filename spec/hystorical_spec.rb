require 'spec_helper'

describe Hystorical do
  describe ".delegate_class" do
    context "when ActiveRecord::Relation" do
      it "should return RubyHystorical" do
        collection = double("ActiveRecord::Relation")
        collection.stub(:class) {ActiveRecord::Relation}
        Hystorical.delegate_class(collection).should eq Hystorical::ARRelation
      end
    end
    context "when not ActiveRecord:Relation" do
      it "should return RubyHystorical" do
        Hystorical.delegate_class(stub).should eq Hystorical::RubyCollection
      end
    end
  end

  let(:collection) { stub }
  describe ".current" do
    before { Hystorical.stub(:delegate_class).and_return(Hystorical::RubyCollection) }
    it "send current message to delegate class" do
      Hystorical::RubyCollection.should_receive(:current).with(collection)
      Hystorical.current(collection)
    end
  end

  describe ".current_on" do
    it "send current_on message to delegate class" do
      date = stub
      Hystorical::RubyCollection.should_receive(:current_on).with(collection, date)
      Hystorical.current_on(collection, date)
    end
  end
end
