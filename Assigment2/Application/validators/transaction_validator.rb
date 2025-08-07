require_relative '../repository/accounts_repository'
require_relative '../repository/transaction_accounts_repository'
require_relative '../errors/validation_error'
class TransactionAccountValidator
  def self.validate(transaction)
    # Validate that IDs are positive integers
    raise ValidationError, 'Sender ID must be a positive integer' unless transaction.sender_id.is_a?(Integer) && transaction.sender_id.positive?
    # Validate that receiver ID is a positive integer
    raise ValidationError, 'Receiver ID must be a positive integer' unless transaction.receiver_id.is_a?(Integer) && transaction.receiver_id.positive?
    # Validate transaction amount
    raise ValidationError, 'Transaction amount must be greater than zero' if transaction.amount.positive? == false

    # Validate transaction timestamp
    raise ValidationError, 'Transaction timestamp cannot be nil' if transaction.timestamp.nil?

    # Get the repository instance
    repository = TransactionAccountsRepository.instance

    # Check for existing transaction with the same details
    existing_transaction = repository.find_transaction_account_by_id(transaction.id)

    # Validate account existence
    raise ValidationError, 'Sender ID cannot be nil or empty' if transaction.sender_id.nil?

    raise ValidationError, 'Receiver ID cannot be nil or empty' if transaction.receiver_id.nil?

    # Validate that sender and receiver are not the same
    raise ValidationError, 'Sender and receiver cannot be the same account' if transaction.sender_id == transaction.receiver_id

    # Validate that the amount does not exceed the sender's balance
    sender_account = AccountRepository.instance.find_account_by_id(transaction.sender_id)
    raise ValidationError, 'Insufficient funds in sender account' if sender_account.balance < transaction.amount

    # Check for duplicate transaction

    raise ValidationError, 'Transaction with these details already exists' if existing_transaction

    true
  end
end
