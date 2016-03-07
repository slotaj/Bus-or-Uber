require "rails_helper"

RSpec.describe "user visits root path", type: :feature do
  scenario "logs in with uber and is taken to the estimates page" do
    visit '/'
    click_on 'Log in with Uber'

    expect(current_path).to eq(ride_estimates_path)
    assert logged_in?
  end
end
