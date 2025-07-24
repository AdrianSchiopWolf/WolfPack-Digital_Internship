class ATMValidator
  def self.validate(atm)
    raise ValidationError, 'ATM ID cannot be nil or empty.' if atm.id.nil?
    raise ValidationError, 'ATM location cannot be nil or empty.' if atm.location.nil? || atm.location.to_s.strip.empty?

    true
  end
end
