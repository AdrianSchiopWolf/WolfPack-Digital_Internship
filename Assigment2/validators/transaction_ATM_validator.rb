class TransactionATMValidator
  def self.validate(transaction)
    raise ValidationError, 'Amount must be greater than zero.' if transaction.amount <= 0

    raise ValidationError, 'ATM ID cannot be empty.' if transaction.atm_id.nil?

    raise ValidationError, 'Account ID cannot be empty.' if transaction.account_id.nil?

    raise ValidationError, 'Amount cannot exceed 5000.' if transaction.amount > 5000 && transaction.is_withdrawal == true

    true
  end
end
