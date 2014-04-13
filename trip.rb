##
# This class describes a trip for GTFS
#
class Trip
  attr_reader :route_id, :service_id, :trip_id

  def initialize(trip_id, calendar_obj, route_obj)
    @trip_id = trip_id
    @service_id = calendar_obj.service_id
    @route_id = route_obj.route_id
  end
end
