require_relative '../repository/transaction_accounts_repository'
require_relative '../repository/accounts_repository'
require_relative '../repository/ATMs_repository'
require_relative '../repository/transaction_ATM_repository'
require_relative '../validators/ATM_validator'
require_relative '../validators/account_validator'
require_relative '../validators/transaction_ATM_validator'
require_relative '../validators/transaction_validator'
require_relative '../errors/validation_error'
require_relative '../model/account'
require_relative '../model/ATMs'
require_relative '../model/transaction_ATM'
require_relative '../model/transaction_account'

class Controller
  def initialize
    @transaction_account_repository = TansactionAccountsRepository.instance
    @transaction_atm_repository = TransactionATMRepository.instance
    @account_repository = AccountRepository.instance
    @atm_repository = ATMsRepository.instance
  end

  # Adds
  def add_atm(atm_attributes)
    atm = ATMs.new(atm_attributes[:id], atm_attributes[:location])

    begin
      ATMValidator.validate(atm)
      @atm_repository.add_atm(atm)
    rescue ValidationError => e
      puts "Error adding ATM: #{e.message}"
    end
  end

  def add_account(account_attributes)
    account = Account.new(account_attributes[:id], account_attributes[:balance], account_attributes[:name],
                          account_attributes[:job], account_attributes[:email], account_attributes[:address])
    begin
      AccountValidator.validate(account)
      @account_repository.add_account(account)
    rescue ValidationError => e
      puts "Error adding account: #{e.message}"
    end
  end

  def add_transaction_atm(transaction_atm_attributes)
    transaction_atm = TransactionATM.new(transaction_atm_attributes[:id], transaction_atm_attributes[:account_id],
                                         transaction_atm_attributes[:atm_id], transaction_atm_attributes[:amount],
                                         transaction_atm_attributes[:timestamp], transaction_atm_attributes[:is_withdrawal] || false)

    begin
      TransactionATMValidator.validate(transaction_atm)
      @transaction_atm_repository.add_transaction_atm(transaction_atm)
      account = @account_repository.find_account_by_id(transaction_atm.account_id)
      new_balance = account.balance + (transaction_atm.is_withdrawal ? -transaction_atm.amount : transaction_atm.amount)
      @account_repository.update_account(transaction_atm.account_id, { balance: new_balance })
    rescue ValidationError => e
      puts "Error adding transaction ATM: #{e.message}"
    end
  end

  def add_transaction_account(transaction_account_attributes)
    transaction_account = TransactionAccount.new(transaction_account_attributes[:id], transaction_account_attributes[:amount],
                                                 transaction_account_attributes[:sender_id], transaction_account_attributes[:reciver_id],
                                                 transaction_account_attributes[:timestamp])
    begin
      TransactionAccountValidator.validate(transaction_account)
      @transaction_account_repository.add_transaction_account(transaction_account)
      new_balance_sender = @account_repository.find_account_by_id(transaction_account.sender_id).balance - transaction_account.amount
      new_balance_reciver = @account_repository.find_account_by_id(transaction_account.reciver_id).balance + transaction_account.amount
      @account_repository.update_account(transaction_account.sender_id, { balance: new_balance_sender })
      @account_repository.update_account(transaction_account.reciver_id, { balance: new_balance_reciver })
    rescue ValidationError => e
      puts "Error adding transaction account: #{e.message}"
    end
  end

  # Deletes
  def delete_account(account_id)
    @account_repository.delete_account(account_id)
  rescue ValidationError => e
    puts "Error deleting account: #{e.message}"
  end

  def delete_atm(atm_id)
    @atm_repository.delete_atm(atm_id)
  rescue ValidationError => e
    puts "Error deleting ATM: #{e.message}"
  end

  # Updates
  def update_account(account_id, attributes)
    @account_repository.update_account(account_id, attributes)
  rescue ValidationError => e
    puts "Error updating account: #{e.message}"
  end

  # Retrieves
  def all_accounts
    @account_repository.all_accounts
  end

  def all_atms
    @atm_repository.all_atms
  end

  def all_transactions_account
    @transaction_account_repository.all_transactions_account
  end

  def all_transactions_atm
    @transaction_atm_repository.all_transactions_atm
  end

  # Retrieves by ID
  def find_account_by_id(account_id)
    @account_repository.find_account_by_id(account_id)
  rescue ValidationError => e
    puts "Error finding account: #{e.message}"
    nil
  end

  def find_atm_by_id(atm_id)
    @atm_repository.find_atm_by_id(atm_id)
  rescue ValidationError => e
    puts "Error finding ATM: #{e.message}"
    nil
  end

  def find_transaction_account_by_id(transaction_id)
    @transaction_account_repository.find_transaction_account_by_id(transaction_id)
  rescue ValidationError => e
    puts "Error finding transaction account: #{e.message}"
    nil
  end

  def find_transaction_atm_by_id(transaction_id)
    @transaction_atm_repository.find_transaction_atm_by_id(transaction_id)
  rescue ValidationError => e
    puts "Error finding transaction ATM: #{e.message}"
    nil
  end
end
