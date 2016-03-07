require 'rails_helper'

RSpec.describe "user saves uber ride info", type: :feature do
  context "user clicks 'Take trip / Save info' button" do
    scenario "user can see uber ride info in dashboard table" do
      visit '/'
      click_on 'Log in with Uber'
      expect(current_path).to eq(ride_estimates_path)

      VCR.use_cassette("user_ride_info") do
        within('#ride-info-input') do
          fill_in("estimates[origin]", with: "1510 Blake Street, Denver Colorado 80202")
          fill_in("estimates[destination]", with: "Denver Zoo")
          click_on "get ride estimates"
        end
        expect(page).to have_content("uberX")

        within('#uberX-estimate-id') do
          click_on('Take trip / Save info')
        end
        expect(page).to have_content("Your trip was successfully saved")

        visit dashboard_path
        expect(page).to have_content(UserTrip.first.trip_type)
        assert_equal "uberX", UserTrip.first.trip_type
      end
    end
  end
end
