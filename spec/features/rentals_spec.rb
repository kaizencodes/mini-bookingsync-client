require "rails_helper"

RSpec.describe "Rentals" do
  let(:rental) do
    { id: "1", name: "Foobar", daily_rate: 1 }
  end
  let(:base_uri) { /\/rentals/ }
  let(:sub_uri) { /\/rentals\/[0-9]+/ }

  before(:example) do
    stub_request(:get, base_uri)
      .to_return(status: :ok, body: [rental].to_json)
    stub_request(:post, base_uri)
    stub_request(:put, base_uri)
    stub_request(:get, sub_uri)
      .to_return(status: :ok, body: rental.to_json)
    stub_request(:delete, sub_uri)
  end

  feature "index page", type: :feature do
    before(:example) { visit rentals_path }

    scenario "visit index page" do
      expect(page).to have_css "h1", text: "Rentals"
      expect(page).to have_css "th", text: "Name"
      expect(page).to have_css "td", text: rental[:name]
      expect(page).to have_css "th", text: "Daily rate"
      expect(page).to have_css "td", text: rental[:daily_rate]

      expect(page).to have_link "Show"
      expect(page).to have_link "New Rental"
      expect(page).to have_link "Edit"
      expect(page).to have_link "Destroy"
    end

    scenario "clicking on show takes to show page" do
      click_on("Show")

      expect(page).to have_current_path(rental_path(rental[:id]))
    end

    scenario "clicking on edit takes to edit page" do
      click_on("Edit")

      expect(page).to have_current_path(edit_rental_path(rental[:id]))
    end

    scenario "clicking on Destroy takes to index page" do
      click_on("Destroy")

      expect(page).to have_current_path(rentals_path)
    end
  end

  feature "show page", type: :feature do
    before(:example) { visit rental_path(rental[:id]) }

    scenario "visit show page" do
      expect(page).to have_css "b", text: "Name"
      expect(page).to have_content rental[:name]
      expect(page).to have_css "b", text: "Daily rate"
      expect(page).to have_content rental[:daily_rate]

      expect(page).to have_link "Edit"
      expect(page).to have_link "Back"
    end

    scenario "clicking on Edit takes to edit page" do
      click_on("Edit")

      expect(page).to have_current_path(edit_rental_path(rental[:id]))
    end

    scenario "clicking on Back takes to index page" do
      click_on("Back")

      expect(page).to have_current_path(rentals_path)
    end
  end

  feature "new page", type: :feature do
    before(:example) { visit new_rental_path }

    scenario "fill out form correctly" do
      fill_in "rental[name]", with: rental[:name]
      fill_in "rental[daily_rate]", with: rental[:daily_rate]
      click_button "Save Rental"

      expect(page).to have_current_path(rentals_path)
    end
  end

  feature "edit page", type: :feature do
    before(:example) { visit edit_rental_path(rental[:id]) }

    scenario "fill out form correctly" do
      fill_in "rental[name]", with: rental[:name]
      fill_in "rental[daily_rate]", with: rental[:daily_rate]
      click_button "Save Rental"

      expect(page).to have_current_path(rental_path(rental[:id]))
    end
  end
end
