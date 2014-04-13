##
# This class describes a route for GTFS
#
class Route
  attr_accessor :route_type
  attr_reader :route_id, :route_short_name, :route_long_name

  def initialize(route_id, route_short_name, route_long_name, route_type = 3)
    @route_id = route_id
    @route_short_name = route_short_name
    @route_long_name = route_long_name
    @route_type = route_type
  end
end
