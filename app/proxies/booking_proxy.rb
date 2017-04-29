class BookingProxy < Proxy
  def path
    "bookings"
  end

  def create(params)
    booking_params = { booking: params.to_h }
    super(booking_params)
  end

  def update(id, params)
    booking_params = { booking: params.to_h }
    super(id, booking_params)
  end

  def calculate_price(to, from, rental_id)
    response = @conn.get do |req|
      req.url "/bookings/calculate_price"
      req.headers["Content-Type"] = "application/json"
      req.params = { to: to, from: from, rental_id: rental_id, token: "global_token" }
    end
    JSON.parse(response.body)
  end
end
