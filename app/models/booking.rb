class Booking < BaseModel
  def self.proxy
    @proxy || @proxy = BookingProxy.new
  end

  def self.attribute_names
    %w[id client_email start_at end_at price rental_id]
  end

  attribute_names.each do |attr|
    define_method(attr.to_s) do
      @attributes[attr.to_s]
    end
  end

  attribute_names.each do |attr|
    define_method("#{attr}=") do |arg|
      @attributes[attr.to_s] = arg
    end
  end

  def rental
    Rental.find(rental_id)
  end

  def start_date
    return unless start_at
    start_at.to_date
  end

  def end_date
    return unless end_at
    end_at.to_date
  end

  def self.calculate_price(to, from, rental_id)
    proxy.calculate_price(to, from, rental_id)
  end
end
