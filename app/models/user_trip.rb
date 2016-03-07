class UserTrip < ActiveRecord::Base
  belongs_to :user

  def self.uber_trips
    where('trip_type LIKE ?', "%uber%")
  end

  def self.uber_trips_total_cost
    uber_trips.sum('cost')
  end

  def self.uber_trips_total_duration
    uber_trips.sum('duration')
  end

  def self.uber_trips_total_distance
    uber_trips.sum('distance')
  end

  def self.bus_trips
    where('trip_type LIKE ?', "%bus%")
  end

  def self.bus_trips_total_cost
    bus_trips.sum('cost')
  end

  def self.bus_trips_total_duration
    bus_trips.sum('duration')
  end

  def self.bus_trips_total_distance
    bus_trips.sum('distance')
  end
end
