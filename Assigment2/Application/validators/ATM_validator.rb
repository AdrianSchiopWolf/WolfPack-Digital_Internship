require_relative '../repository/ATMs_repository'

class ATMValidator
  def self.validate(atm)
    raise ValidationError, 'ATM ID cannot be nil or empty.' if atm.id.nil?
    raise ValidationError, 'ATM location cannot be nil or empty.' if atm.location.nil? || atm.location.to_s.strip.empty?

    repository = ATMsRepository.instance
    existing_atm = repository.find_atm_by_id(atm.id)
    raise ValidationError, 'ATM with this ID already exists.' if existing_atm

    true
  end
end
