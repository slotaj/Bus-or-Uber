require 'rails_helper'

RSpec.describe "user saves bus ride info", type: :feature do
  context "user clicks 'Take trip / Save info' button" do
    scenario "user can see bus ride info in dashboard table" do
      visit '/'
      click_on 'Log in with Uber'
      expect(current_path).to eq(ride_estimates_path)

      VCR.use_cassette("user_bus_ride_info") do
        within('#ride-info-input') do
          fill_in("estimates[origin]", with: "1510 Blake Street, Denver Colorado 80202")
          fill_in("estimates[destination]", with: "Denver Zoo")
          click_on "get ride estimates"
        end

        within("#bus-estimate-id") do
          click_on('Take trip / Save info')
        end
        expect(page).to have_content("Your trip was successfully saved")

        visit dashboard_path
        expect(page).to have_content(UserTrip.first.duration)
        assert_equal "bus", UserTrip.first.trip_type
      end
    end
  end
end
