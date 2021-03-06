class GoogleEstimate
  attr_reader :estimate_info, :warning, :status

  def initialize(estimate_hash)
    @estimate_info ||= estimate_hash.routes[0]['legs'][0]
    @warning       ||= estimate_hash.routes[0]['warning']
    @status        ||= estimate_hash.status
  end

  def self.create(origin, destination)
    estimate_hash = GoogleEstimateService.new.full(origin, destination)
    @estimate     = new(estimate_hash)
  end

  def self.estimate
    @estimate
  end

  def departure_time
    estimate_info['departure_time']['text']
  end

  def arrival_time
    estimate_info['arrival_time']['text']
  end

  def duration
    estimate_info['duration']['text']
  end

  def duration_data
    estimate_info['duration']['value']
  end

  def start_address
    estimate_info['start_address']
  end

  def end_address
    estimate_info['end_address']
  end

  def distance
    estimate_info['distance']['text']
  end

  def steps
    estimate_info['steps'].map do |step|
      step = build_object(step)
      if step.steps
        step.steps.map do |step|
          build_object(step)
        end
      end
      step
    end
  end

  private

  def build_object(data)
    OpenStruct.new(data)
  end
end
