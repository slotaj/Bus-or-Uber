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
        assert_equal 5, estimate.prices.count
      end
    end
  end
end
