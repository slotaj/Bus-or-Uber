class AddUserIdToUserTrip < ActiveRecord::Migration
  def change
    add_reference :user_trips, :user, index: true
  end
end
