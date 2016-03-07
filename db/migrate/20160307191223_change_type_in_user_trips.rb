class ChangeTypeInUserTrips < ActiveRecord::Migration
  def change
    remove_column :user_trips, :type, :string
    add_column    :user_trips, :trip_type, :string
  end
end
