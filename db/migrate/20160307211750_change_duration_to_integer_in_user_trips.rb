class ChangeDurationToIntegerInUserTrips < ActiveRecord::Migration
  def change
    remove_column :user_trips, :duration, :string
    add_column :user_trips, :duration, :integer
  end
end
