require_relative '../spec_helper'
require 'byebug'

RSpec.describe 'TransactionAccount' do
  let(:transaction_account) { TransactionAccount.new(1, 100.0, 1, 2, Time.now) }

  describe '#setter and getter methods' do
    it 'sets and gets id' do
      transaction_account.id = 1
      expect(transaction_account.id).to eq(1)
    end

    it 'sets and gets amount' do
      transaction_account.amount = 100.0
      expect(transaction_account.amount).to eq(100.0)
    end

    it 'sets and gets sender_id' do
      transaction_account.sender_id = 1
      expect(transaction_account.sender_id).to eq(1)
    end

    it 'sets and gets receiver_id' do
      transaction_account.receiver_id = 2
      expect(transaction_account.receiver_id).to eq(2)
    end

    it 'sets and gets timestamp' do
      time = Time.now
      transaction_account.timestamp = time
      expect(transaction_account.timestamp).to eq(time)
    end
  end
end
