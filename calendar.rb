##
# This class describes a calendar object for GTFS.
#
class Calendar
  attr_reader :service_id

  def initialize(service_id, start_date, end_date, days)
    @service_id = service_id
    @monday = days[:monday]
    @tuesday = days[:tuesday]
    @wednesday = days[:wednesday]
    @thursday = days[:thursday]
    @friday = days[:friday]
    @saturday = days[:saturday]
    @sunday = days[:sunday]
    @start_date = start_date
    @end_date = end_date
  end
end
