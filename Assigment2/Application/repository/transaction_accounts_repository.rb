require 'singleton'

class TransactionAccountsRepository
  include Singleton
  def initialize
    @transaction_accounts = []
  end

  def add_transaction_account(transaction_account)
    @transaction_accounts << transaction_account
  end

  def all_transaction_accounts
    @transaction_accounts
  end

  def find_transaction_account_by_id!(transaction_id)
    transaction = find_transaction_account_by_id(transaction_id)
    raise ValidationError, 'Transaction account not found' unless transaction

    transaction
  end

  def find_transaction_account_by_id(transaction_id)
    @transaction_accounts.find { |transaction| transaction.id == transaction_id }
  end

  def clear
    @transaction_accounts.clear
  end
end
