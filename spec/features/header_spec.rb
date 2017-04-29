require "rails_helper"

RSpec.feature "Header", type: :feature do
  include_examples "stubs"

  scenario "clicking on rental takes to rental index page" do
    visit root_path

    click_on("Rentals")

    expect(page).to have_current_path(rentals_path)
  end

  scenario "clicking on booking takes to booking index page" do
    visit root_path

    click_on("Bookings")

    expect(page).to have_current_path(bookings_path)
  end
end
