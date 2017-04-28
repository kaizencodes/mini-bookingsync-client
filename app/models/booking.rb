class Booking
  @@proxy = BookingProxy.new

  def initialize(attributes = {})
    @attributes = attributes
  end

  def self.all
    bookings_attributes = @@proxy.all
    bookings_attributes.map { |booking_attrs| new(booking_attrs) }
  end

  def self.find(id)
    new(@@proxy.find(id))
  end

  def self.get_price(to, from, rental_id)
    @@proxy.get_price(to, from, rental_id)
  end

  # TODO: metaprogramming refacor

  def id
    @attributes["id"]
  end

  def client_email
    @attributes["client_email"]
  end

  def client_email=(value)
    @attributes["client_email"] = value
  end

  # TODO: fix this
  def start_at
    @attributes["start_at"].to_date rescue nil
  end

  def start_at=(value)
    @attributes["start_at"] = value
  end

  def end_at
    @attributes["end_at"].to_date rescue nil
  end

  def end_at=(value)
    @attributes["end_at"] = value
  end


  def price
    @attributes["price"]
  end

  def price=(value)
    @attributes["price"] = value
  end

  def rental_id
    @attributes["rental_id"]
  end

  def rental_id=(value)
    @attributes["rental_id"] = value
  end


  attr_reader :errors

  def create
    response = @@proxy.create(@attributes)
    if response.success?
      return true
    else
      @errors = JSON.parse(response.body)
      return false
    end
  end

  def update(params)
    params.each { |k, v| @attributes[k] = v }
    response = @@proxy.update(id, params)
    if response.success?
      return true
    else
      @errors = JSON.parse(response.body)
      return false
    end
  end

  def destroy
    response = @@proxy.destroy(id)
    response.success? ? true : false
  end
end
