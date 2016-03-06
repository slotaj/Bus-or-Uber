class UberService

  attr_reader :connection

  def initialize
    @connection = Faraday.new(:url => 'https://api.uber.com') do |faraday|
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def time_estimate(start_long_and_lat, end_long_and_lat)
    response = connection.get do |req|
      req.url '/v1/estimates/time'
      req.params['server_token']    = ENV['uber_server_token']
      req.params['start_latitude']  = start_long_and_lat['lat']
      req.params['start_longitude'] = start_long_and_lat['lng']
      req.params['end_latitude']    = end_long_and_lat['lat']
      req.params['end_longitude']   = end_long_and_lat['lng']
    end
    build_object(response.body)
  end

  def price_estimate(start_long_and_lat, end_long_and_lat)
    response = connection.get do |req|
      req.url '/v1/estimates/price'
      req.params['server_token']    = ENV['uber_server_token']
      req.params['start_latitude']  = start_long_and_lat['lat']
      req.params['start_longitude'] = start_long_and_lat['lng']
      req.params['end_latitude']    = end_long_and_lat['lat']
      req.params['end_longitude']   = end_long_and_lat['lng']
    end
    build_object(response.body)
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end

  def build_object(data)
    OpenStruct.new(data)
  end

end
