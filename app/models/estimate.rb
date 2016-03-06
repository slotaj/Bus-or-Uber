class Estimate
  attr_reader :directions_info, :warning, :status

  def initialize(google_directions_hash, uber_directions_hash)
    @directions_info ||= google_directions_hash.routes[0]['legs'][0]
    @warning ||= google_directions_hash.routes[0]['warning']
    @status ||= google_directions_hash.status
  end

  def self.create(origin, destination)
    google_directions_hash = GoogleDirectionsService.new.full(origin, destination)
    start_long_and_lat = google_directions_hash.routes.first['legs'].first['start_location']
    end_long_and_lat = google_directions_hash.routes.first['legs'].first['end_location']
    uber_price_estimate = UberService.new.price_estimate(start_long_and_lat, end_long_and_lat)
    # uber_time_estimate = UberServices.new.time_estimate(start_long_and_lat, end_long_and_lat)
    @google_directions = new(google_directions_hash, uber_price_estimate)
  end

  def self.google_directions
    @google_directions
  end

  def departure_time
    directions_info['departure_time']['text']
  end

  def arrival_time
    directions_info['arrival_time']['text']
  end

  def duration
    directions_info['duration']['text']
  end

  def start_address
    directions_info['start_address']
  end

  def end_address
    directions_info['end_address']
  end

  def distance
    directions_info['distance']['text']
  end

  def steps
    # byebug
    # make an new class to define steps so I can pass objects to the view
    directions_info['steps'].map do |step|
      step = build_object(step)
      if step.steps
        step.steps.map do |step|
          build_object(step)
        end
      end
      step
    end
  end

  def end_location_lat
    directions_info['end_location']['lat'] #send to Uber
  end

  def start_location_lat
    directions_info['start_location']['lat'] #send to Uber
  end

  def start_location_lng
    directions_info['start_location']['lng'] #send to Uber
  end

  def end_location_lng
    directions_info['end_location']['lng'] #send to Uber
  end

  private

  def build_object(data)
    OpenStruct.new(data)
  end
end
