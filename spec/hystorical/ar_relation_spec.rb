require 'spec_helper'

describe Hystorical::ARRelation do

  with_model :Subscription do
    table do |t|
      t.integer :user_id
      t.string :service
      t.date :start_date
      t.date :end_date
    end

    model do
      def self.for_user(user_id)
        where user_id: user_id
      end
    end
  end

  describe "current" do
    let!(:obj1) { Subscription.create(user_id: 1, service: "gold", start_date: Date.new(2012, 9, 1), end_date: nil) }
    let!(:obj2) { Subscription.create(user_id: 2, service: "silver", start_date: Date.new(2012, 9, 6), end_date: Date.new(2012, 9, 10)) }
    let!(:obj3) { Subscription.create(user_id: 2, service: "gold", start_date: Date.new(2012, 9, 11), end_date: nil) }

    it "should return the current subscription" do
      Hystorical::ARRelation.current(Subscription.for_user(2)).should eq [obj3]
    end

    context "block filter" do
      let!(:obj4) { Subscription.create(user_id: 2, service: "silver", start_date: Date.new(2012, 9, 6), end_date: nil) }
      it "should return the current filtered subscriptions" do
        Hystorical::ARRelation.current Subscription.for_user(2) do |sub|
          sub.service == "silver"
        end.should eq [obj4]
      end
    end
  end

  describe "current_on" do
    let!(:obj1) { Subscription.create(user_id: 1, start_date: Date.new(2012, 9, 1), end_date: nil) }
    let!(:obj2) { Subscription.create(user_id: 2, start_date: Date.new(2012, 9, 6), end_date: Date.new(2012, 9, 10)) }
    let!(:obj3) { Subscription.create(user_id: 2, start_date: Date.new(2012, 9, 11), end_date: nil) }

    it "should return the current subscription as of Sept 8" do
      Hystorical::ARRelation.current_on(Subscription.for_user(2), Date.new(2012, 9, 8)).should eq [obj2]
    end

    context "block filter" do
      let!(:obj4) { Subscription.create(user_id: 2, service: "gold", start_date: Date.new(2012, 9, 6), end_date: Date.new(2012, 9, 10)) }
      it "should return the current filtered subscriptions" do
        Hystorical::ARRelation.current_on Subscription.for_user(2), Date.new(2012, 9, 8) do |sub|
          sub.service == "gold"
        end.should eq [obj4]
      end
    end
  end
end
