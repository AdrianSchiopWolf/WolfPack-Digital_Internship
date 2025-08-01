class ValidationError < StandardError
  def initialize(message = 'Validation failed')
    super(message)
  end
end
