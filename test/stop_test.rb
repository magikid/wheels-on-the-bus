require 'minitest/autorun'
require './stop.rb'

describe Stop, 'testing Stop class' do
  before do
    @stop = Stop.new(0, "", 0, 0)
  end

  it 'returns a stop object' do
    @stop.must_be_kind_of(Stop)
  end
end
