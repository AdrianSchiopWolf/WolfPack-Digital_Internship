require_relative '../spec_helper'
require 'byebug'

RSpec.describe 'Account' do
  let(:account) { Account.new(1, 1000.0, 'John Doe', 'Software Engineer', 'john.doe@example.com', '123 Main St') }

  describe '#setter and getter methods' do
    it 'sets and gets id' do
      account.id = 1
      expect(account.id).to eq(1)
    end

    it 'sets and gets balance' do
      account.balance = 100.0
      expect(account.balance).to eq(100.0)
    end

    it 'sets and gets name' do
      account.name = 'John Doe'
      expect(account.name).to eq('John Doe')
    end

    it 'sets and gets job' do
      account.job = 'Software Engineer'
      expect(account.job).to eq('Software Engineer')
    end

    it 'sets and gets email' do
      account.email = 'john.doe@example.com'
      expect(account.email).to eq('john.doe@example.com')
    end

    it 'sets and gets address' do
      account.address = '123 Main St'
      expect(account.address).to eq('123 Main St')
    end
  end
end
