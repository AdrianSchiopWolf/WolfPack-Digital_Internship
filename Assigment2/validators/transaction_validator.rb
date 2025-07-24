require_relative '../repository/accounts_repository'
class TransactionAccountValidator
  def self.validate(transaction)
    # Validate transaction amount
    raise ValidationError, 'Transaction amount must be greater than zero' if transaction.amount.nil? || transaction.amount <= 0

    # Validate account existence
    raise ValidationError, 'Sender ID cannot be nil or empty' if transaction.sender_id.nil?

    raise ValidationError, 'Receiver ID cannot be nil or empty' if transaction.reciver_id.nil?

    # Validate that sender and receiver are not the same
    raise ValidationError, 'Sender and receiver cannot be the same account' if transaction.sender_id == transaction.reciver_id

    # Validate that the amount does not exceed the sender's balance
    sender_account = AccountRepository.instance.find_account_by_id(transaction.sender_id)
    raise ValidationError, 'Insufficient funds in sender account' if sender_account.balance < transaction.amount

    # Validate that IDs are positive integers
    raise ValidationError, 'Sender ID must be a positive integer' unless transaction.sender_id.is_a?(Integer) && transaction.sender_id > 0
    raise ValidationError, 'Receiver ID must be a positive integer' unless transaction.reciver_id.is_a?(Integer) && transaction.reciver_id > 0

    true
  end
end
