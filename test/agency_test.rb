require_relative 'test_helper'

describe Agency, "testing Agency clas" do
  before do
    @a = Agency.new(
      "Anchorage People Mover",
      "http://localhost",
      "AKST"
    )
  end

  it "must have an agency name" do
    @a.name.must_be(:==, "Anchorage People Mover")
  end

  it "must have a url" do
    @a.url.must_be(:==, "http://localhost")
  end

  it "must have a timezone" do
    @a.timezone.must_be(:==, "AKST")
  end

  it "allows agency id" do
    @a.agency_id = 1
    @a.agency_id.must_be_kind_of(Numeric)
  end

  it "makes agency id only be number" do
    proc {@a.agency_id = "a"}.must_raise(ArgumentError)
  end

  it "allows language in initialization" do
    test_a = Agency.new(name="", url="", timezone="",
      language: "English"
    )
    test_a.language.must_be(:==,"English")
  end

  it "allows language to be changed" do
    @a.language = "English"
    @a.language.must_be(:==, "English")
  end

  it "allows a phone number to be set" do
    test_a = Agency.new("", "", "",
      phone_number: "555-555-5555"
    )
    test_a.phone_number.must_be(:==, "555-555-5555")
  end

  it "allows a phone number to be changed" do
    @a.phone_number = "555-555-5555"
    @a.phone_number.must_be(:==, "555-555-5555")
  end

  it "allows an agency fare url to be set" do
    test_a = Agency.new("", "", "",
      fare_url: "http://localhost"
    )
    test_a.fare_url.must_be(:==, "http://localhost")
  end

  it "allows fare url to be changed" do
    @a.fare_url = "http://localhost"
    @a.fare_url.must_be(:==, "http://localhost")
  end

end
