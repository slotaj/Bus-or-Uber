class RideEstimatesController < ApplicationController

  def index
    @google_directions = GoogleDirections.directions
  end

  def create
    @google_directions = GoogleDirections.create(estimates_params[:origin],
                                                 estimates_params[:destination])
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
# @route_directions     = TransitRide.directions
# or refactor to make objects with attributes to call usng the trick Josh Showed me
# refactor this controller to call a decorator which aggregates the info into one instance variable to send over
