class AccountValidator
  def self.validate(account)
    raise ValidationError, 'ID cannot be nil' if account.id.nil?
    raise ValidationError, 'Balance must be a number' unless account.balance.is_a?(Numeric)
    raise ValidationError, 'Name cannot be nil' if account.name.nil? || account.name.strip.empty?
    raise ValidationError, 'Job cannot be nil' if account.job.nil? || account.job.strip.empty?
    raise ValidationError, 'Email cannot be nil' if account.email.nil? || account.email.strip.empty?
    raise ValidationError, 'Address cannot be nil' if account.address.nil? || account.address.strip.empty?
    raise ValidationError, 'Balance cannot be negative' if account.balance < 0
    raise ValidationError, 'ID must be a positive integer' unless account.id.is_a?(Integer) && account.id > 0

    raise ValidationError, 'Name can only contain alphabetic characters and spaces' unless account.name =~ /\A[a-zA-Z\s]+\z/

    raise ValidationError, 'Job title can only contain alphabetic characters and spaces' unless account.job =~ /\A[a-zA-Z\s]+\z/

    raise ValidationError, 'Email format is invalid' unless account.email =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    true
  end
end
