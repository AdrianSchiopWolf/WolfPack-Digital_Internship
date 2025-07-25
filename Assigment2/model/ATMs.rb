class ATMs
  attr_accessor :id, :location

  def initialize(id, location)
    @id = id
    @location = location
  end

  def to_s
    "ATM ID: #{@id}, Location: #{@location}"
  end
end
