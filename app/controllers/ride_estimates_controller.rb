class RideEstimatesController < ApplicationController

  def index
    @google_estimate = GoogleEstimate.estimate
    @uber_estimate = UberEstimate.estimate
  end

  def create
    byebug
    google_estimate = GoogleEstimate.create(estimates_params[:origin],
                                                 estimates_params[:destination])
    start_lat  = google_estimate.estimate_info['start_location']['lat']
    start_lng  = google_estimate.estimate_info['start_location']['lng']
    end_lat  = google_estimate.estimate_info['end_location']['lat']
    end_lng = google_estimate.estimate_info['end_location']['lng']
    UberEstimate.create(start_lat, start_lng, end_lat, end_lng)
    redirect_to action: 'index'
  end

  private

  def estimates_params
    params.require(:estimates).permit(:origin, :destination)
  end
end

# @uber_cost            = UberRide.cost
# @uber_trip_time       = UberRide.trip_time
# @uber_arrival_time    = UberRide.arrival_time
# @uber_pick_up_time    = UberRide.pick_up_time
# @transit_cost         = TransitRide.cost
# @transit_trip_time    = TransitRide.trip_time
# @transit_arrival_time = TransitRide.arrival_time
# @map                  = TransitRide.map
# @route_estimate     = TransitRide.estimate
# or refactor to make objects with attributes to call usng the trick Josh Showed me
# refactor this controller to call a decorator which aggregates the info into one instance variable to send over
