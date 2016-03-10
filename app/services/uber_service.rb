
class UberService

  attr_reader :connection

  def initialize
    @connection = Faraday.new(:url => 'https://api.uber.com') do |faraday|
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def get_estimate(start_lat, start_lng, end_lat, end_lng)
    time_estimate_response  = time_estimate(start_lat, start_lng)
    price_estimate_response = price_estimate(start_lat, start_lng, end_lat, end_lng)

    combine_and_format_responses(time_estimate_response, price_estimate_response)
  end

  def combine_and_format_responses(time_estimate_response, price_estimate_response)
    price_estimate_response = price_estimate_response.prices.map.with_index do |price_estimate, i|
      trip_duration = time_estimate_response.times[i]['estimate']
      price_estimate['duration'] = price_estimate['duration'] / 60
      price_estimate.merge!('estimated_uber_arrival' => trip_duration / 60)
      build_object(price_estimate)
    end
  end

  def time_estimate(start_lat, start_lng)
    response = connection.get do |req|
      req.url '/v1/estimates/time'
      req.params['server_token']    = ENV['uber_server_token']
      req.params['start_latitude']  = start_lat
      req.params['start_longitude'] = start_lng
    end
    build_object(parse(response))
  end

  def price_estimate(start_lat, start_lng, end_lat, end_lng)
    response = connection.get do |req|
      req.url '/v1/estimates/price'
      req.params['server_token']    = ENV['uber_server_token']
      req.params['start_latitude']  = start_lat
      req.params['start_longitude'] = start_lng
      req.params['end_latitude']    = end_lat
      req.params['end_longitude']   = end_lng
    end
    build_object(parse(response))
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end

  def build_object(data)
    OpenStruct.new(data)
  end

end
