require 'rails_helper'

RSpec.describe "user gets ride estimes", type: :feature do
  context "user inputs valid data" do
    scenario "gets a ride estimate for a local in town ride and sees expected data" do
      visit '/'
      click_on 'Log in with Uber'
      expect(current_path).to eq(ride_estimates_path)
      VCR.use_cassette("directions1") do
        within('#ride-info-input') do
          fill_in("Origin", with: "1510 Blake Street, Denver Colorado 80202")
          fill_in("Destination", with: "Denver Zoo")
          click_on "get ride estimates"

          expect(page).to have_content("")
        end
      end
    end

    # scenario "user gets a ride estimate for a long distance across state ride" do
    # end
  end

  # context "user inputs invalid data" do
  #   scenario "user can not get an estimate with bad start location data" do
  #   end
  #
  #   scenario "user can not get an estimate with bad end location data" do
  #   end
  # end
end
