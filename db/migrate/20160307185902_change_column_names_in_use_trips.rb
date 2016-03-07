class ChangeColumnNamesInUseTrips < ActiveRecord::Migration
  def change
    remove_column :user_trips, :trip_type, :string
    add_column    :user_trips, :type, :string
    remove_column :user_trips, :trip_price_estimate, :string
    add_column    :user_trips, :price_estimate, :string
    remove_column :user_trips, :trip_duration, :string
    add_column    :user_trips, :duration, :string
    remove_column :user_trips, :trip_distance, :integer
    add_column    :user_trips, :distance, :integer
    remove_column :user_trips, :trip_cost, :decimal
    add_column    :user_trips, :cost, :decimal
  end
end
