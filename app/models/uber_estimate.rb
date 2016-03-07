require 'action_view'

include ActionView::Helpers::DateHelper
class UberEstimate

  attr_reader :ride_estimates, :uber_arrival_estimates

  def initialize(ride_estimates, uber_arrival_estimates)
    @ride_estimates             = sanitize_ride_estimates(ride_estimates)
    @uber_arrival_estimates     = sanitize_arrival_estimates(uber_arrival_estimates)
  end

  def self.create(start_lat, start_lng, end_lat, end_lng)
    ride_estimates         = UberService.new.price_estimate(start_lat, start_lng, end_lat, end_lng)
    uber_arrival_estimates = UberService.new.time_estimate(start_lat, start_lng)
    @info = new(ride_estimates, uber_arrival_estimates)
  end

  def self.estimate
    @info
  end

  def sanitize_ride_estimates(ride_estimates) # this is crutial!!!! this method goes into the hash and the 'prices' key to get the right info
    ride_estimates.prices.map do |ride|
      ride['duration'] = trip_duration(ride['duration'])
      build_object(ride)
    end
  end

  def sanitize_arrival_estimates(uber_arrival_estimates)
    uber_arrival_estimates.map do |uber_estimate|
      uber_estimate['estimate'] = trip_duration(uber_estimate['estimate'])
      build_object(estimate)
    end
  end

  def trip_duration(trip_duration)
    distance_of_time_in_words(Time.now, Time.now + trip_duration)
  end

  private


  def build_object(data)
    OpenStruct.new(data)
  end
end
