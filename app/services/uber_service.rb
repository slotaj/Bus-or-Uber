require 'action_view'

include ActionView::Helpers::DateHelper
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
    price_estimate_response = price_estimate_response.prices.map.with_index do |price_estimate, i|
      trip_duration = time_estimate_response.times[i]['estimate']
      price_estimate['duration'] = distance_of_time_in_words(Time.now, Time.now + price_estimate['duration'])
      price_estimate.merge!('estimated_uber_arrival' => distance_of_time_in_words(Time.now, Time.now + trip_duration))
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

  # def sanitize_ride_estimates(ride_estimates) # this is crutial!!!! this method goes into the hash and the 'prices' key to get the right info
  #   ride_estimates.prices.map do |ride|
  #     ride['duration'] = trip_duration(ride['duration'])
  #     build_object(ride)
  #   end
  # end
  #
  # def sanitize_arrival_estimates(uber_arrival_estimates)
  #   uber_arrival_estimates.map do |uber_estimate|
  #     uber_estimate['estimate'] = trip_duration(uber_estimate['estimate'])
  #     build_object(estimate)
  #   end
  # end
  #
  # def trip_duration(time)
  #   distance_of_time_in_words(Time.now, Time.now + time)
  # end

  private

  def parse(response)
    JSON.parse(response.body)
  end

  def build_object(data)
    OpenStruct.new(data)
  end

end
