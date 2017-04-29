class BookingsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "bookings"
  end

  def calculate_price(data)
    price = Booking.calculate_price(data["to"], data["from"], data["rental_id"])
    ActionCable.server.broadcast("bookings", price)
  end
end
