##
# This class is used to describe the stops
# in the Google Transit Feed Spec.
#
class Stop
  def initialize(stop_id, stop_name, stop_lat, stop_lon)
    @stop_name = stop_name
    @stop_id = stop_id
    @stop_lat = stop_lat
    @stop_lon = stop_lon
  end
end
