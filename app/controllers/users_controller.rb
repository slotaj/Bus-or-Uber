class UsersController < ApplicationController
  def show
    @uber_trips = current_user.user_trips.where('trip_type LIKE ?', "%uber%")
    @bus_trips = current_user.user_trips.where('trip_type LIKE ?', "%bus%")
  end
end
