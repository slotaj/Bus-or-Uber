require 'action_view'

include ActionView::Helpers::DateHelper
class UberEstimate

  attr_reader :ride_estimates

  def initialize(ride_estimates)
    @ride_estimates = ride_estimates
  end

  def self.create(start_lat, start_lng, end_lat, end_lng)
    ride_estimates = UberService.new.get_estimate(start_lat, start_lng, end_lat, end_lng)
    @info = new(ride_estimates)
  end

  def self.estimate
    @info
  end

end
