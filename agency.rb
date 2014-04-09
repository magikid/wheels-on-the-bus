##
# This class is used to generate the agency.txt file required
# in the Google Transit Feed Spec.
#
class Agency
  attr_reader :name, :url, :timezone, :agency_id
  attr_accessor :language, :phone_number, :fare_url

  def initialize(name, url, timezone, options = {})
    @name = name
    @url = url
    @timezone = timezone
    @language = options[:language]
    @phone_number = options[:phone_number]
    @fare_url = options[:fare_url]
  end

  def agency_id=(agency_id)
    if agency_id.kind_of? Numeric
      @agency_id = agency_id
    else
      fail ArgumentError
    end
  end
end
