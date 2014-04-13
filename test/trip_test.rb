require 'minitest/autorun'
require './trip.rb'

describe Trip, 'trip class for GTFS' do

  before do
    @calendar = Calendar.new(1, '20140101', '20141231',
                             monday: true,
                             tuesday: true,
                             wednesday: true,
                             thursday: true,
                             friday: true,
                             saturday: true,
                             sunday: true)
    @route = Route.new(2, '', '')
  end

  it 'requires a calendar object and a stop object' do
    trip = Trip.new(3, @calendar, @route)
    trip.must_be_kind_of(Trip)
  end

  it 'must give out the trip_id, service_id and route_id' do
    trip = Trip.new(4, @calendar, @route)
    trip.route_id.must_be(:==, 2)
    trip.service_id.must_be(:==, 1)
    trip.trip_id.must_be(:==, 4)
  end
end
