require 'action_view'

include ActionView::Helpers::DateHelper
class UberEstimate

  attr_reader :ride_estimates

  def initialize(ride_estimates)
    ride_estimates = ride_estimates.map do |ride|
      ride['duration'] = trip_duration(ride['duration'])
      build_object(ride)
    end
    @ride_estimates = ride_estimates
  end

  def self.create(start_lat, start_lng, end_lat, end_lng)
    ride_estimates = UberService.new.price_estimate(start_lat, start_lng, end_lat, end_lng)
    @info = new(ride_estimates.prices)
  end

  def self.estimate
    @info
  end

  def trip_duration(trip_duration)
    distance_of_time_in_words(Time.now, Time.now + trip_duration)
  end

  private

  def build_object(data)
    OpenStruct.new(data)
  end
end
