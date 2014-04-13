require 'minitest/autorun'
require './gtfs.rb'

describe Gtfs do
  before do
    @gtfs = Gtfs.new
  end

  it 'must exist' do
    @gtfs.wont_be_nil
  end
end
