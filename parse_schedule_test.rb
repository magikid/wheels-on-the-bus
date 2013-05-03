require 'test/unit'
require 'shoulda'
require 'parse_schedule'

class WheelsTesting < Test::Unit::TestCase
	context "Parser for bus schedules" do
		setup do
			@bus = Busses.new
		end

		should "have route 1 but not 103" do
			assert_equal true, @bus.isroute?(1)
			assert_equal false, @bus.isroute?(103)
		end

		should "have stop 'Lake Otis and Dowling' but not 'A and C'" do
			assert_equal true, @bus.ismainstop?("LAKE OTIS and DOWLING")
			assert_equal false, @bus.ismainstop?("A and C")
		end
	end
end
