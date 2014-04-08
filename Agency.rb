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
      raise ArgumentError
    end
  end

end
