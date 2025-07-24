require 'singleton'

class TansactionAccountsRepository
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

  def find_transaction_account_by_id(transaction_id)
    @transaction_accounts.find { |transaction| transaction.id == transaction_id }
  end
end
