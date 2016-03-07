require "rails_helper"

RSpec.describe "User views Monthly totals", type: :feature do
  context "user visits dashboard page" do
    before(:each) do
      visit '/'
      click_on 'Log in with Uber'
      expect(current_path).to eq(ride_estimates_path)
      20.times do |i|
        UserTrip.create!(user_id: User.last.id,
        cost: rand(2..40),
        distance: rand(1..20),
        duration: "#{rand(1..50)} minutes",
        trip_type: ["bus", "ubeX", "uberBlack"].sample)
      end
    end

    scenario "views information for trips taken by both uber and buses" do
      visit dashboard_path
      user = User.last
      expect(page).to have_css("#uber-trip", :count => user.user_trips.where('trip_type LIKE ?', "%uber%").count )
      expect(page).to have_css("#bus-trip", :count => user.user_trips.where('trip_type LIKE ?', "%bus%").count )
    end

    scenario "views monthly totals" do
      visit dashboard_path
      user = User.last
      expect(page).to have_css("#uber-trip", :count => user.user_trips.where('trip_type LIKE ?', "%uber%").count )
      expect(page).to have_css("#bus-trip", :count => user.user_trips.where('trip_type LIKE ?', "%bus%").count )

      within('#monthly-totals') do
        expect(page).to have_content("Uber")
        expect(page).to have_content("Bus")
        expect(page).to have_content(user.user_trips.uber_trips.uber_trips_total_cost)
        expect(page).to have_content(user.user_trips.uber_trips.uber_trips_total_duration)
        expect(page).to have_content(user.user_trips.bus_trips.uber_trips_total_distance)
      end
    end
  end
end
