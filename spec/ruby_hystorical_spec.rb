describe RubyHystorical do

  let(:collection) do
    [
      {id: 1, start_date: Date.new(2012, 8, 15), end_date: Date.new(2012, 8, 26)},
      {id: 2, start_date: Date.new(2012, 8, 27), end_date: Date.new(2012, 9, 4)},
      {id: 3, start_date: Date.new(2012, 9, 5), end_date: nil}
    ]
  end

  describe ".current" do
    context "when attributes are accessed via []" do
      it "should return the current object" do
        RubyHystorical.current(collection).should eq [{id: 3, start_date: Date.new(2012, 9, 5), end_date: nil}]
      end
    end
  end
end