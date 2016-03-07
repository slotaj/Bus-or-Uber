class CreateUserTrips < ActiveRecord::Migration
  def change
    create_table :user_trips do |t|
      t.string :trip_type
      t.decimal :trip_price_estimate
      t.string :trip_duration
      t.integer :trip_distance
      t.decimal :trip_cost

      t.timestamps null: false
    end
  end
end
