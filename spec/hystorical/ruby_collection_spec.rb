require 'spec_helper'

describe Hystorical::RubyCollection do
  class HistoricalObjet
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
    end
  end

  let(:obj1) { {start_date: Date.new(2012, 8, 15), end_date: Date.new(2012, 8, 26)} }
  let(:obj2) { {start_date: Date.new(2012, 8, 27), end_date: Date.new(2012, 9, 4)} }
  let(:obj3) { {start_date: Date.new(2012, 9, 5), end_date: nil} }
  let(:collection) { [obj1, obj2, obj3] }


  let(:obj4) { HistoricalObjet.new(Date.new(2012, 8, 15), Date.new(2012, 8, 26)) }
  let(:obj5) { HistoricalObjet.new(Date.new(2012, 8, 27), Date.new(2012, 9, 4)) }
  let(:obj6) { HistoricalObjet.new(Date.new(2012, 9, 5), nil) }
  let(:collection2) { [obj4, obj5, obj6] }

  describe ".current" do
    context "when attributes are accessed via []" do
      it "should return the current object" do
        Hystorical::RubyCollection.current(collection).should eq [obj3]
      end
    end

    context "when attributes are accessed via ." do
      it "should return the current object" do
        Hystorical::RubyCollection.current(collection2).should eq [obj6]
      end
    end
  end

  describe ".current_on" do
    let(:date) { Date.new(2012, 9, 1) }

    context "when attributes are accessed via []" do
      it "should return the current object" do
        Hystorical::RubyCollection.current_on(collection, date).should eq [obj2]
      end
    end

    context "when attributes are accessed via ." do
      it "should return the current object" do
        Hystorical::RubyCollection.current_on(collection2, date).should eq [obj5]
      end
    end
  end
end
