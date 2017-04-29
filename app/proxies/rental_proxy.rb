class RentalProxy < Proxy

  def path
    "rentals"
  end

  def create(params)
    rental_params = { rental: params.to_h }
    super(rental_params)
  end

  def update(id, params)
    rental_params = { rental: params.to_h }
    super(id, rental_params)
  end
end
