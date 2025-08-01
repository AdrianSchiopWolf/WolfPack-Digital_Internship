require_relative '../repository/transaction_ATM_repository'

class TransactionATMValidator
  def self.validate(transaction)
    repository = TransactionATMRepository.instance
    start_date = Time.now - 24 * 60 * 60 # 24 hours ago
    transactions = repository.all_transaction_atm
    sum_of_transations = transactions.sum { |t| (t.amount if t.is_withdrawal == true && t.timestamp >= start_date) || 0 } if transactions.any?

    raise ValidationError, 'Transaction ATM ID cannot be empty.' if transaction.id.nil? || transaction.id <= 0

    raise ValidationError, 'Account ID cannot be empty.' if transaction.account_id.nil? || transaction.account_id <= 0

    raise ValidationError, 'ATM ID cannot be empty.' if transaction.atm_id.nil? || transaction.atm_id <= 0

    raise ValidationError, 'Amount must be greater than zero.' if transaction.amount <= 0

    raise ValidationError, 'Timestamp cannot be in the future.' if transaction.timestamp > Time.now

    if transaction.is_withdrawal && sum_of_transations && sum_of_transations + transaction.amount > 5000
      raise ValidationError,
            'Transaction amount exceeds daily limit of 5000.'
    end

    # Check for withdrawal limits
    raise ValidationError, 'Can\'t withdraw more than 5000 in total in 24h.' if sum_of_transations && sum_of_transations + transaction.amount > 5000

    raise ValidationError, 'Amount must be greater than zero.' if transaction.amount <= 0

    raise ValidationError, 'ATM ID cannot be empty.' if transaction.atm_id.nil?

    raise ValidationError, 'Account ID cannot be empty.' if transaction.account_id.nil?

    raise ValidationError, 'Amount cannot exceed 5000.' if transaction.amount > 5000 && transaction.is_withdrawal == true

    true
  end
end
