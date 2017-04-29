RSpec.shared_examples "stubs" do
  let(:rental) do
    { id: "1", name: "Foobar", daily_rate: 1 }
  end
  let(:booking) do
    { id: "1", rental_id: rental["id"],
      client_email: "example@email.com",
      start_at: Date.today,
      end_at: Date.tomorrow, price: 1 }
  end
  let(:base_booking_uri) { /\/bookings/ }
  let(:base_rental_uri) { /\/rentals/ }
  let(:sub_booking_uri) { /\/bookings\/[0-9]+/ }
  let(:sub_rental_uri) { /\/rentals\/[0-9]+/ }

  before(:example) do
    stub_request(:get, base_booking_uri)
      .to_return(status: :ok, body: [booking].to_json)
    stub_request(:post, base_booking_uri)
    stub_request(:put, base_booking_uri)
    stub_request(:get, sub_booking_uri)
      .to_return(status: :ok, body: booking.to_json)
    stub_request(:delete, sub_booking_uri)

    stub_request(:get, base_rental_uri)
      .to_return(status: :ok, body: [rental].to_json)
    stub_request(:post, base_rental_uri)
    stub_request(:put, base_rental_uri)
    stub_request(:get, sub_rental_uri)
      .to_return(status: :ok, body: rental.to_json)
    stub_request(:delete, sub_rental_uri)
  end
end
