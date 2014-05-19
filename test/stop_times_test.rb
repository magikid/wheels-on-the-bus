require 'minitest/autorun'
require './stop_times.rb'

describe Stop, 'testing Stop Times class' do
  before do
    @stop_times = StopTimes.new()
  end

  it 'returns a stop times object' do
    @stop.must_be_kind_of(StopTimes)
  end

end
