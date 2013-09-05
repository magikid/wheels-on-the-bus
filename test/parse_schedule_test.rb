require 'test/unit'
require 'shoulda'
require './parse_schedule.rb'

class WheelsTesting < Test::Unit::TestCase
	context "Parser for bus schedules" do
		setup do
			@bus = Busses.new
		end

		should "have route 1 but not 103" do
			assert_equal true, @bus.isroute?(1)
			assert_equal false, @bus.isroute?(103)
		end

		should "have stop 'Lake Otis and Dowling' but not 'A and C' on route 1" do
			assert_equal [1], @bus.ismainstop?("LAKE OTIS and DOWLING", 1)
			assert_equal [], @bus.ismainstop?("A and C", 1)
		end

		should "have 'Dimond Center' on several routes" do
			assert_equal [1, 2, 7, 9, 60], @bus.ismainstop?("DIMOND CENTER")
		end

		should "have schedule for route 1, westbound" do
			assert_equal 6, @bus.route(1, 0).keys.length
			assert_equal @bus.route(1, 0).keys, ["DEBARR and MULDOON", "BAXTER and NORTHERN LIGHTS", "AK NATIVE MED CENTER", "PROVIDENCE and ALUMNI", "LAKE OTIS and DOWLING", "DIMOND CENTER"]
			assert_equal "06:10:00", @bus.route(1, 0)["DEBARR and MULDOON"][0]
		end

		should "have schedule for route 1, eastbound" do
			assert_equal 6, @bus.route(1, 1).keys.length
		end

		should "have all routes in the all_routes method" do
			assert_equal 14, @bus.all_routes.keys.length
			assert_equal [1,2,3,7,8,9,13,14,15,36,45,60,75,102], @bus.all_routes.keys
		end

		should "have Saturday schedule for route 13" do
			assert_equal @bus.route(13,0,"Saturday").keys.length, 8
			#assert_equal @bus.route(13,0,"Saturday")["DOWNTOWN TRANSIT CENTER"][0], "08:20:00"
		end
	end
end
