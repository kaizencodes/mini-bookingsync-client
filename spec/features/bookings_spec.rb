require "rails_helper"

RSpec.describe "Bookings" do
  let(:booking) do
    { id: "1", client_email: "example@email.com", start_at: Date.today, end_at: Date.tomorrow, price: 1}
  end
  let(:rental) do
    { id: "1", name: "Foobar", daily_rate: 1 }
  end
  let(:base_uri) { /\/bookings/ }
  let(:base_rental_uri) { /\/rentals/ }
  let(:sub_uri) { /\/bookings\/[0-9]+/ }

  before(:example) do
    stub_request(:get, base_uri)
      .to_return(status: :ok, body: [booking].to_json)
    stub_request(:get, base_rental_uri)
      .to_return(status: :ok, body: [rental].to_json)
    stub_request(:post, base_uri)
    stub_request(:put, base_uri)
    stub_request(:get, sub_uri)
      .to_return(status: :ok, body: booking.to_json)
    stub_request(:delete, sub_uri)
  end

  feature "index page", type: :feature do
    before(:example) { visit bookings_path }

    scenario "visit index page" do
      expect(page).to have_css "h1", text: "Bookings"
      expect(page).to have_css "th", text: "Client email"
      expect(page).to have_css "td", text: booking[:client_email]

      expect(page).to have_css "th", text: "Start at"
      expect(page).to have_css "td", text: booking[:start_at]

      expect(page).to have_css "th", text: "End at"
      expect(page).to have_css "td", text: booking[:end_at]

      expect(page).to have_css "th", text: "Price"
      expect(page).to have_css "td", text: booking[:price]

      expect(page).to have_link "Show"
      expect(page).to have_link "New Booking"
      expect(page).to have_link "Edit"
      expect(page).to have_link "Destroy"
    end

    scenario "clicking on show takes to show page" do
      click_on("Show")

      expect(page).to have_current_path(booking_path(booking[:id]))
    end

    scenario "clicking on edit takes to edit page" do
      click_on("Edit")

      expect(page).to have_current_path(edit_booking_path(booking[:id]))
    end

    scenario "clicking on Destroy takes to index page" do
      click_on("Destroy")

      expect(page).to have_current_path(bookings_path)
    end
  end

  feature "show page", type: :feature do
    before(:example) { visit booking_path(booking[:id]) }

    scenario "visit show page" do
      expect(page).to have_css "b", text: "Client email"
      expect(page).to have_content booking[:client_email]

      expect(page).to have_css "b", text: "Start at"
      expect(page).to have_content booking[:start_at]

      expect(page).to have_css "b", text: "End at"
      expect(page).to have_content booking[:end_at]

      expect(page).to have_css "b", text: "Price"
      expect(page).to have_content booking[:price]

      expect(page).to have_link "Edit"
      expect(page).to have_link "Back"
    end

    scenario "clicking on Edit takes to edit page" do
      click_on("Edit")

      expect(page).to have_current_path(edit_booking_path(booking[:id]))
    end

    scenario "clicking on Back takes to index page" do
      click_on("Back")

      expect(page).to have_current_path(bookings_path)
    end
  end

  feature "new page", type: :feature do
    before(:example) { visit new_booking_path }

    scenario "fill out form correctly" do
      fill_in "booking[client_email]", with: booking[:client_email]
      # fill_in "booking[start_at]", with: booking[:start_at]
      # fill_in "booking[end_at]", with: booking[:end_at]

      click_button "Save Booking"

      expect(page).to have_current_path(bookings_path)
    end
  end

  feature "edit page", type: :feature do
    before(:example) { visit edit_booking_path(booking[:id]) }

    scenario "fill out form correctly" do
      fill_in "booking[client_email]", with: booking[:client_email]
      # fill_in "booking[start_at]", with: booking[:start_at]
      # fill_in "booking[end_at]", with: booking[:end_at]

      click_button "Save Booking"

      expect(page).to have_current_path(booking_path(booking[:id]))
    end
  end
end
