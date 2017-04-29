class Rental < BaseModel
  def self.proxy
    @proxy || @proxy = RentalProxy.new
  end

  def self.attribute_names
    %w[id name daily_rate]
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
end
