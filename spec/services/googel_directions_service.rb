require 'rails_helper'

describe  "Google directions estimate service" do
  context "google diections" do
    it "returns directions" do

      VCR.use_cassette("google_directions#full") do
        origin = "375 Elati Street, Denver Colorado 80223"
        destination = "Denver Zoo"
        service = GoogleEstimateService.new
        estimate = service.full(origin, destination)
        assert_equal 5, estimate.routes.first['legs'].first['steps'].count
      end
    end
  end
end
