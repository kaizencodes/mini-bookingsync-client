class BookingProxy
  def initialize
    @conn = Faraday.new(url: "http://localhost:3000")
  end

  def all
    response = @conn.get "/bookings?token=global_token"
    JSON.parse(response.body)
  end

  def find(id)
    response = @conn.get "/bookings/" + id.to_s + "/?token=global_token"
    JSON.parse(response.body)
  end

  def create(params)
    @conn.post do |req|
      req.url "/bookings"
      req.headers["Content-Type"] = "application/json"
      req.params = { booking: params.to_h, token: "global_token" }
    end
  end

  def update(id, params)
    @conn.put do |req|
      req.url "/bookings/" + id.to_s
      req.headers["Content-Type"] = "application/json"
      req.params = { bookings: params.to_h, token: "global_token" }
    end
  end

  def destroy(id)
    @conn.delete "/bookings/" + id.to_s + "/?token=global_token"
  end

  def get_price(to, from, rental_id)
    response = @conn.get do |req|
      req.url "/bookings/get_price"
      req.headers["Content-Type"] = "application/json"
      req.params = { to: to, from: from, rental_id: rental_id, token: "global_token" }
    end
    JSON.parse(response.body)
  end
end
