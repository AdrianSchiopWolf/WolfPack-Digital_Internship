require_relative '../spec_helper'

RSpec.describe 'TransactionATMRepository' do
  let(:transaction_atm_repository) { TransactionATMRepository.instance }
  let(:transaction_atm) { TransactionATM.new(1, 1, 1, 100.0, Time.now, true) }

  describe '#add_transaction_atm' do
    it 'adds a transaction ATM to the repository' do
      transaction_atm_repository.add_transaction_atm(transaction_atm)
      expect(transaction_atm_repository.all_transaction_atm.size).to eq(1)
      expect(transaction_atm_repository.all_transaction_atm.first.id).to eq(1)
      expect(transaction_atm_repository.all_transaction_atm.first.amount).to eq(100.0)
      expect(transaction_atm_repository.all_transaction_atm.first.account_id).to eq(1)
      expect(transaction_atm_repository.all_transaction_atm.first.atm_id).to eq(1)
      expect(transaction_atm_repository.all_transaction_atm.first.is_withdrawal).to be true
    end
  end

  describe '#all_transaction_atm' do
    it 'returns all transaction ATMs' do
      transaction_atm_repository.add_transaction_atm(transaction_atm)
      transactions = transaction_atm_repository.all_transaction_atm
      expect(transactions.size).to eq(1)
      expect(transactions.first.id).to eq(1)
      expect(transactions.first.amount).to eq(100.0)
      expect(transactions.first.account_id).to eq(1)
      expect(transactions.first.atm_id).to eq(1)
      expect(transactions.first.is_withdrawal).to be true
    end
  end

  describe '#find_transaction_atm_by_id' do
    it 'finds a transaction ATM by ID' do
      transaction_atm_repository.add_transaction_atm(transaction_atm)
      found_transaction = transaction_atm_repository.find_transaction_atm_by_id(1)
      expect(found_transaction).to eq(transaction_atm)
    end

    it 'returns nil if transaction ATM not found' do
      expect(transaction_atm_repository.find_transaction_atm_by_id(999)).to be_nil
    end
  end

  describe '#find_transaction_atm_by_id!' do
    it 'finds a transaction ATM by ID' do
      transaction_atm_repository.add_transaction_atm(transaction_atm)
      found_transaction = transaction_atm_repository.find_transaction_atm_by_id!(1)
      expect(found_transaction).to eq(transaction_atm)
    end

    it 'raises an error if transaction ATM not found' do
      expect { transaction_atm_repository.find_transaction_atm_by_id!(999) }.to raise_error('Transaction ATM not found')
    end
  end
end
