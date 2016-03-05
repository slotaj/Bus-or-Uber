class GoogleDirectionsService
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



#?????????? try using more than one transit mode to get bus and train ???????????
# transit_mode — Specifies one or more preferred modes of transit. This parameter may only be specified for transit directions, and only if the request includes an API key or a Google Maps APIs Premium Plan client ID. The parameter supports the following arguments:
# bus indicates that the calculated route should prefer travel by bus.
# subway indicates that the calculated route should prefer travel by subway.
# train indicates that the calculated route should prefer travel by train.
# tram indicates that the calculated route should prefer travel by tram and light rail.
# rail indicates that the calculated route should prefer travel by train, tram, light rail, and subway. This is equivalent to transit_mode=train|tram|subway.
