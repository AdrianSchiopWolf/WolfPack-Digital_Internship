require_relative '../spec_helper'

RSpec.describe 'TransactionAccountRepository' do
  let(:transaction_account_repository) { TransactionAccountsRepository.instance }
  let(:transaction_account) { TransactionAccount.new(1, 100.0, 1, 2, Time.now) }

  describe '#add_transaction_account' do
    it 'adds a transaction account to the repository' do
      transaction_account_repository.add_transaction_account(transaction_account)
      expect(transaction_account_repository.all_transaction_accounts.size).to eq(1)
      expect(transaction_account_repository.all_transaction_accounts.first.id).to eq(1)
      expect(transaction_account_repository.all_transaction_accounts.first.amount).to eq(100.0)
    end
  end

  describe '#all_transaction_accounts' do
    it 'returns all transaction accounts' do
      transaction_account_repository.add_transaction_account(transaction_account)
      transactions = transaction_account_repository.all_transaction_accounts
      expect(transactions.size).to eq(1)
      expect(transactions.first.id).to eq(1)
      expect(transactions.first.amount).to eq(100.0)
      expect(transactions.first.sender_id).to eq(1)
      expect(transactions.first.receiver_id).to eq(2)
    end
  end

  describe '#find_transaction_account_by_id' do
    it 'finds a transaction account by ID' do
      transaction_account_repository.add_transaction_account(transaction_account)
      found_transaction = transaction_account_repository.find_transaction_account_by_id(1)
      expect(found_transaction).to eq(transaction_account)
    end

    it 'returns nil if transaction account not found' do
      expect(transaction_account_repository.find_transaction_account_by_id(999)).to be_nil
    end
  end

  describe '#find_transaction_account_by_id!' do
    it 'finds a transaction account by ID' do
      transaction_account_repository.add_transaction_account(transaction_account)
      found_transaction = transaction_account_repository.find_transaction_account_by_id!(1)
      expect(found_transaction).to eq(transaction_account)
    end

    it 'raises an error if transaction account not found' do
      expect { transaction_account_repository.find_transaction_account_by_id!(999) }.to raise_error('Transaction account not found')
    end
  end
end
