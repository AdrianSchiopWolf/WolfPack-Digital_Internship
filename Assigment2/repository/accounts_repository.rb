require_relative '../model/account'
require_relative '../errors/validation_error'
require 'singleton'
class AccountRepository
  include Singleton

  def initialize
    @accounts = []
  end

  def add_account(account)
    @accounts << account
  end

  def all_accounts
    @accounts
  end

  def delete_account(account_id)
    find_account_by_id(account_id)
    @accounts.reject! { |account| account.id == account_id }
  end

  def find_account_by_id(account_id)
    account = @accounts.find { |account| account.id == account_id }
    raise ValidationError, 'Account not found' unless account

    account
  end

  def update_account(account_id, attributes)
    account = find_account_by_id(account_id)
    attributes.each do |key, value|
      if account.respond_to?("#{key}=")
        account.send("#{key}=", value)
      else
        puts "Attribute #{key} does not exist on Account"
      end
    end
  end
end
