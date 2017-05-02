class Rental < BaseModel
  def self.proxy
    @proxy || @proxy = RentalProxy.new
  end

  def self.attribute_names
    %w[id name daily_rate]
  end

  attr_accessors_for { attribute_names }
end
