class UberService

  attr_reader :connection

  def initialize
    @connection = Faraday.new(:url => 'https://api.uber.com') do |faraday|
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def price_estimate(input)
    # response = connection.get do |req|                           # GET http://sushi.com/search?page=2&limit=100
  #   req.url '/v1/estimates/price/'
    #   req.params['start_latitude'] =
    #   req.params['start_longitude'] =
    #   req.params['end_latitude'] =
    #   req.params['end_longitude'] =
    # end

  end
end



# start_latitude	float	Latitude component of start location.
# start_longitude	float	Longitude component of start location.
# end_latitude	float	Latitude component of end location.
# end_longitude	float	Longitude component of end location.
