require_relative '../spec_helper'
require 'byebug'

RSpec.describe 'TransactionATM' do
  let(:transaction_atm) { TransactionATM.new(1, 1, 1, 100.0, Time.now, true) }

  describe '#setter and getter methods' do
    it 'sets and gets id' do
      transaction_atm.id = 1
      expect(transaction_atm.id).to eq(1)
    end

    it 'sets and gets account_id' do
      transaction_atm.account_id = 1
      expect(transaction_atm.account_id).to eq(1)
    end

    it 'sets and gets atm_id' do
      transaction_atm.atm_id = 1
      expect(transaction_atm.atm_id).to eq(1)
    end

    it 'sets and gets amount' do
      transaction_atm.amount = 100.0
      expect(transaction_atm.amount).to eq(100.0)
    end

    it 'sets and gets timestamp' do
      time = Time.now
      transaction_atm.timestamp = time
      expect(transaction_atm.timestamp).to eq(time)
    end

    it 'sets and gets is_withdrawal' do
      transaction_atm.is_withdrawal = true
      expect(transaction_atm.is_withdrawal).to be true
    end
  end
end
