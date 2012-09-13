require 'spec_helper'

describe Hystorical::ARRelation do

  with_model :Subscription do
    table do |t|
      t.integer :user_id
      t.date :start_date
      t.date :end_date
    end

    model do
      def self.for_user(user_id)
        where user_id: user_id
      end
    end
  end


  it "should have ARRelation" do
    Subscription.create(user_id: 1, end_date: Date.new(2012, 9, 5))
    Subscription.create(user_id: 2, end_date: Date.new(2012, 9, 10))
    raise Subscription.for_user(1).class.to_yaml
  end
end
