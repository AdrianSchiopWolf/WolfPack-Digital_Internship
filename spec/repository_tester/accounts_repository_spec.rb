require_relative '../spec_helper'
require 'byebug'

RSpec.describe 'AccountRepository' do
  let(:account_repository) { AccountRepository.instance }
  let(:account) { Account.new(1, 1000.0, 'John Doe', 'Software Engineer', 'john.doe@example.com', '123 Main St') }

  describe '#add_account' do
    it 'adds a new account' do
      account_repository.add_account(account)
      expect(account_repository.all_accounts.size).to eq(1)
      expect(account_repository.all_accounts.first.id).to eq(1)
    end
  end

  describe '#all_accounts' do
    it 'returns all accounts' do
      account_repository.add_account(account)
      accounts = account_repository.all_accounts
      expect(accounts.size).to eq(1)
      expect(accounts.first.id).to eq(1)
      expect(accounts.first.name).to eq('John Doe')
    end
  end
  describe '#find_account_by_id' do
    it 'finds an account by ID' do
      account_repository.add_account(account)
      found_account = account_repository.find_account_by_id(1)
      expect(found_account).to eq(account)
    end

    it 'returns nil if account not found' do
      expect(account_repository.find_account_by_id(999)).to be_nil
    end
  end

  describe '#find_account_by_id!' do
    it 'finds an account by ID' do
      account_repository.add_account(account)
      found_account = account_repository.find_account_by_id!(1)
      expect(found_account).to eq(account)
    end

    it 'raises an error if account not found' do
      expect { account_repository.find_account_by_id!(999) }.to raise_error('Account not found')
    end
  end

  describe '#update_account' do
    it 'updates an existing account' do
      account_repository.add_account(account)
      account_repository.update_account(1, { balance: 2000.0 })
      updated_account = account_repository.find_account_by_id(1)
      expect(updated_account.balance).to eq(2000.0)
    end

    it 'raises an error if account not found' do
      expect { account_repository.update_account(2, { balance: 2000.0 }) }.to raise_error('Account not found')
    end
  end

  describe '#delete_account' do
    it 'deletes an existing account' do
      account_repository.add_account(account)
      account_repository.delete_account(1)
      expect(account_repository.all_accounts.size).to eq(0)
    end

    it 'raises an error if account not found' do
      expect { account_repository.delete_account(999) }.to raise_error('Account not found')
    end
  end

  describe '#clear' do
    it 'clears all accounts' do
      account_repository.add_account(account)
      account_repository.clear
      expect(account_repository.all_accounts.size).to eq(0)
    end
  end
end
