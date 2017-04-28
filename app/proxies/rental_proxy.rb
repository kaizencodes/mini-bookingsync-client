class RentalProxy
  def initialize
    @conn = Faraday.new(url: "http://localhost:3000")
  end

  def all
    response = @conn.get "/rentals?token=global_token"
    JSON.parse(response.body)
  end

  def find(id)
    response = @conn.get "/rentals/" + id.to_s + "/?token=global_token"
    JSON.parse(response.body)
  end

  def create(params)
    @conn.post do |req|
      req.url "/rentals"
      req.headers["Content-Type"] = "application/json"
      req.params = { rental: params.to_h, token: "global_token" }
    end
  end

  def update(id, params)
    @conn.put do |req|
      req.url "/rentals/" + id.to_s
      req.headers["Content-Type"] = "application/json"
      req.params = { rental: params.to_h, token: "global_token" }
    end
  end

  def destroy(id)
    @conn.delete "/rentals/" + id.to_s + "/?token=global_token"
  end
end
