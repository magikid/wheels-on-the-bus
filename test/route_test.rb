require 'minitest/autorun'
require './route.rb'

describe Route, 'testing Route class' do
  before do
    @route = Route.new(0, '', '')
  end

  it 'should default route_type to 3' do
    @route.route_type.must_be(:==, 3)
  end

  it 'should allow read access to route id, short name and long name' do
    @route.route_id.must_be(:==, 0)
    @route.route_short_name.must_be(:==, '')
    @route.route_long_name.must_be(:==, '')
  end
end
