class Rental
  @@proxy = RentalProxy.new

  def initialize(attributes = {})
    @attributes = attributes
  end

  def self.all
    rentals_attributes = @@proxy.all
    rentals_attributes.map { |rental_attrs| new(rental_attrs) }
  end

  def self.find(id)
    new(@@proxy.find(id))
  end

  # TODO: metaprogramming refacor

  def id
    @attributes["id"]
  end

  def name
    @attributes["name"]
  end

  def name=(value)
    @attributes["name"] = value
  end

  def daily_rate
    @attributes["daily_rate"]
  end

  def daily_rate=(value)
    @attributes["daily_rate"] = value
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
