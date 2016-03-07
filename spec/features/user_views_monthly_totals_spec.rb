require "rails_helper"

RSpec.describe "User views Monthly totals", type: :feature do
  context "user visits dashboard page" do
    scenario "views information for trips taken by both uber and buses" do
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

      visit dashboard_path
      save_and_open_page
      user = User.last
      expect(page).to have_css("#uber-trip", :count => user.user_trips.where('trip_type LIKE ?', "%uber%").count )
      expect(page).to have_css("#bus-trip", :count => user.user_trips.where('trip_type LIKE ?', "%bus%").count )

    end
  end
end
