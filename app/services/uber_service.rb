class UberService

  attr_reader :connection

  def initialize
    @connection = Faraday.new(:url => 'https://api.uber.com') do |faraday|
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def time_estimate(start_long_and_lat, end_long_and_lat)
    response = connection.get do |req|
      req.url '/v1/estimates/time'
      req.headers['Authorization'] = ENV['uber_server_token']
      # Authorization: Bearer YOUR_ACCESS_TOKEN
      req.params['start_latitude']  = start_long_and_lat['lat']
      req.params['start_longitude'] = start_long_and_lat['lng']
      req.params['end_latitude']    = end_long_and_lat['lat']
      req.params['end_longitude']   = end_long_and_lat['lng']
    end
  end

# https://api.uber.com/v1/estimates/price?start_latitude=39.7223747&start_longitude=-104.9939991&end_latitude=39.7579206&end_longitude=-104.9935264&server_token=cH2wK_7jEDRe4IaKgO7wFD1v_YyQlMF7uqJpW_sW
# https://api.uber.com/v1/estimates/price/?end_latitude=39.7579206&end_longitude=-104.9935264&start_latitude=39.7223747&start_longitude=-104.9939991


  def price_estimate(start_long_and_lat, end_long_and_lat)
    response = connection.get do |req|
      req.url '/v1/estimates/price'
      req.params['server_token']    = ENV['uber_server_token']
      req.params['start_latitude']  = start_long_and_lat['lat']
      req.params['start_longitude'] = start_long_and_lat['lng']
      req.params['end_latitude']    = end_long_and_lat['lat']
      req.params['end_longitude']   = end_long_and_lat['lng']
    end
  end

end



# start_latitude	float	Latitude component of start location.
# start_longitude	float	Longitude component of start location.
# end_latitude	float	Latitude component of end location.
# end_longitude	float	Longitude component of end location.
