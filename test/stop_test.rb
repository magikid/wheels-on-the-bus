require 'minitest/autorun'
require './stop.rb'

describe Stop, 'testing Stop class' do
  before do
    @stop = Stop.new(0, '', 0, 0)
  end

  it 'returns a stop object' do
    @stop.must_be_kind_of(Stop)
  end

  it 'must accept changes to args' do
    @stop.stop_name = 'Hi'
    @stop.stop_name.must_be(:==, 'Hi')
    @stop.stop_id = 1
    @stop.stop_id.must_be(:==, 1)
    @stop.stop_lat = '94.123'
    @stop.stop_lat.must_be(:==, '94.123')
    @stop.stop_lon = '123.233'
    @stop.stop_lon.must_be(:==, '123.233')
  end
end
