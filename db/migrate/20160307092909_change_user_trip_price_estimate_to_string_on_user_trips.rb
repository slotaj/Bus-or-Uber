class ChangeUserTripPriceEstimateToStringOnUserTrips < ActiveRecord::Migration
  def change
    change_column :user_trips, :trip_price_estimate, :string
  end
end
