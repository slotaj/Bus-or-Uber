require 'rails_helper'

describe  "Uber Services" do
  context "price estimate" do
    it "returns price estimate hash" do

      VCR.use_cassette("uber_service#price") do
        start_lat = 39.7223747
        start_lng = -104.9939991
        end_lat   = 39.7579206
        end_lng   = -104.9935264
        service   = UberService.new
        estimate  = service.price_estimate(start_lat, start_lng, end_lat, end_lng)
        # byebug
        assert_equal 5, estimate.prices.count
      end
    end
  end
end


# def price_estimate(start_lat, start_lng, end_lat, end_lng)
#   response = connection.get do |req|
#     req.url '/v1/estimates/price'
#     req.params['server_token']    = ENV['uber_server_token']
#     req.params['start_latitude']  = start_lat
#     req.params['start_longitude'] = start_lng
#     req.params['end_latitude']    = end_lat
#     req.params['end_longitude']   = end_lng
#   end
#   build_object(parse(response))
# end
