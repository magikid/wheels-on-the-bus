require "test/unit"

class TestGtfsClass < Test::Unit::TestCase
  context "Testing for Gtfs class" do

    setup do
      @gtfs = Gtfs.new
    end

    should "exist" do
      assert_not_nil(@gtfs)
    end


  end
end
