class UsersController < ApplicationController
  def show
    @uber_trips = current_user.user_trips.uber_trips
    @bus_trips = current_user.user_trips.bus_trips
  end
end
