require 'minitest/autorun'
require './calendar.rb'

describe Calendar, 'calendar class for GTFS' do
  before do
    @calendar = Calendar.new(0, '20140101', '20141231',
                             monday: true,
                             tuesday: true,
                             wednesday: true,
                             thursday: true,
                             friday: true,
                             saturday: true,
                             sunday: true)
  end

  it 'allows read access to service_id' do
    @calendar.service_id.must_be(:==, 0)
  end
end
