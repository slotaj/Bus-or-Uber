class GoogleEstimateService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: 'https://maps.googleapis.com/') do |faraday|
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter
      faraday.params[:key] = ENV['google_maps_server_key']
    end
  end

  def full(origin, destination)
    response = connection.get do |req|
      req.url('maps/api/directions/json')
      req.params['mode']         = 'transit'
      req.params['origin']       = origin
      req.params['destination']  = destination
      req.params['transit_mode'] = 'bus'
    end
    build_object(parse(response))
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end

  def build_object(data)
    OpenStruct.new(data)
  end
end
