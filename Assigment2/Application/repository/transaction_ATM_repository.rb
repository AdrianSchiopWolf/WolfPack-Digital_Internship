require 'singleton'

class TransactionATMRepository
  include Singleton

  def initialize
    @transaction_accounts = []
  end

  def add_transaction_atm(transaction_account)
    @transaction_accounts << transaction_account
  end

  def all_transaction_atm
    @transaction_accounts
  end

  def find_transaction_atm_by_id!(transaction_id)
    transaction = find_transaction_atm_by_id(transaction_id)
    raise ValidationError, 'Transaction ATM not found' unless transaction

    transaction
  end

  def find_transaction_atm_by_id(transaction_id)
    @transaction_accounts.find { |transaction| transaction.id == transaction_id }
  end

  def clear
    @transaction_accounts.clear
  end
end
