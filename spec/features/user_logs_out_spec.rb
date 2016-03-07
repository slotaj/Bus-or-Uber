require "rails_helper"

RSpec.describe "user visits root path, logs in", type: :feature do
  scenario "logs out and is taken to the root path" do
    visit '/'
    click_on 'Log in with Uber'
    click_on 'logout'

    expect(current_path).to eq(root_path)
    refute current_user.logged_in?
  end
end
