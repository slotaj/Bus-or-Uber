class Estimate
  # attr_reader :estimate_hash_info, :warning, :status
  #
  # def initialize(google_estimate_hash, uber_estimate_hash)
  #   @estimate_hash_info ||= google_estimate_hash.routes[0]['legs'][0]
  #   @warning ||= google_estimate_hash.routes[0]['warning']
  #   @status ||= google_estimate_hash.status
  # end
  # attr_reader :google_estimate, :uber_estimate

  # def initialize(google_estimate_hash, uber_price_estimate = nil)
  #   @google_estimate = google_estimate_hash
  #   @uber_price_estimate  = uber_price_estimate
  # end

  def self.create(origin, destination)

    # google_estimate_hash = GoogleDirectionsService.new.full(origin, destination)
    @google_estimate_hash = GoogleEstimate.get_estimate(origin, destination)
    # start_long_and_lat   = google_estimate_hash.routes.first['legs'].first['start_location']
    # end_long_and_lat     = google_estimate_hash.routes.first['legs'].first['end_location']
    #
    # uber_price_estimate  = UberService.new.price_estimate(start_long_and_lat, end_long_and_lat)

    # uber_time_estimate = UberServices.new.time_estimate(start_long_and_lat, end_long_and_lat)
    # @estimates = new(google_estimate_hash)#, uber_price_estimate)
  end

  def self.get_google_estimate
    @google_estimate_hash
  end












  # def departure_time
  #   estimate_hash_info['departure_time']['text']
  # end
  #
  # def arrival_time
  #   estimate_hash_info['arrival_time']['text']
  # end
  #
  # def duration
  #   estimate_hash_info['duration']['text']
  # end
  #
  # def start_address
  #   estimate_hash_info['start_address']
  # end
  #
  # def end_address
  #   estimate_hash_info['end_address']
  # end
  #
  # def distance
  #   estimate_hash_info['distance']['text']
  # end
  #
  # def steps
  #   # byebug
  #   # make an new class to define steps so I can pass objects to the view
  #   estimate_hash_info['steps'].map do |step|
  #     step = build_object(step)
  #     if step.steps
  #       step.steps.map do |step|
  #         build_object(step)
  #       end
  #     end
  #     step
  #   end
  # end
  #
  # def end_location_lat
  #   estimate_hash_info['end_location']['lat'] #send to Uber
  # end
  #
  # def start_location_lat
  #   estimate_hash_info['start_location']['lat'] #send to Uber
  # end
  #
  # def start_location_lng
  #   estimate_hash_info['start_location']['lng'] #send to Uber
  # end
  #
  # def end_location_lng
  #   estimate_hash_info['end_location']['lng'] #send to Uber
  # end

  private

  def build_object(data)
    OpenStruct.new(data)
  end
end
