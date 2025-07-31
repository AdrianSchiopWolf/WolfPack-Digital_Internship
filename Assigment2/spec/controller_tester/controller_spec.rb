require_relative '../spec_helper'
require 'byebug'
RSpec.describe 'Controller' do
  let(:controller) { Controller.new }

  # Test for adding
  describe '#add_account' do
    it 'adds a valid account' do
      account_attributes = { id: 1, name: 'John Doe', job: 'Developer', email: 'adrian@gmail.com', address: '123 Main St', balance: 1000.0 }
      expect { controller.add_account(account_attributes) }.not_to raise_error
    end

    it 'raises an error for invalid account' do
      account_attributes = { id: nil, name: '', job: '', email: '', address: '', balance: -100.0 }
      expect { controller.add_account(account_attributes) }.to output(/Error adding account/).to_stdout
    end

    it 'raises an error for duplicate account ID' do
      account_attributes = { id: 1, name: 'Jane Doe', job: 'Designer', email: 'ada@gmail.com', address: '456 Elm St', balance: 500.0 }
      controller.add_account(account_attributes) # First call should succeed
      expect { controller.add_account(account_attributes) }.to output(/Error adding account/).to_stdout
    end

    it 'raises an error for invalid email format' do
      account_attributes = { id: 2, name: 'Alice', job: 'Manager', email: 'invalid-email', address: '789 Oak St', balance: 2000.0 }
      expect { controller.add_account(account_attributes) }.to output(/Error adding account/).to_stdout
    end

    it 'raises an error for invalid name format' do
      account_attributes = { id: 3, name: 'John123', job: 'Tester', email: 'ada@gmail.com', address: '101 Pine St', balance: 3000.0 }
      expect { controller.add_account(account_attributes) }.to output(/Error adding account/).to_stdout
    end

    it 'raises an error for invalid job format' do
      account_attributes = { id: 4, name: 'Bob', job: 'Tester123', email: 'adrian@gmail.com', address: '202 Maple St', balance: 1500.0 }
      expect { controller.add_account(account_attributes) }.to output(/Error adding account/).to_stdout
    end

    it 'raises an error for negative balance' do
      account_attributes = { id: 5, name: 'Charlie', job: 'Analyst', email: 'adri@gmail.com', address: '303 Birch St', balance: -500.0 }
      expect { controller.add_account(account_attributes) }.to output(/Error adding account/).to_stdout
    end

    it 'raises an error for non-positive ID' do
      account_attributes = { id: -1, name: 'Dave', job: 'Engineer', email: 'adad@gmail.com', address: '404 Cedar St', balance: 1000.0 }
      expect { controller.add_account(account_attributes) }.to output(/Error adding account/).to_stdout
    end

    it 'raises an error for nil ID' do
      account_attributes = { id: nil, name: 'Eve', job: 'Designer', email: 'adad@gmail.com', address: '505 Spruce St', balance: 800.0 }
      expect { controller.add_account(account_attributes) }.to output(/Error adding account/).to_stdout
    end
  end

  describe '#add_atm' do
    it 'adds a valid ATM' do
      atm_attributes = { id: 1, location: 'Downtown' }
      expect { controller.add_atm(atm_attributes) }.not_to raise_error
    end

    it 'raises an error for invalid ATM' do
      atm_attributes = { id: nil, location: '' }
      expect { controller.add_atm(atm_attributes) }.to output(/Error adding ATM/).to_stdout
    end

    it 'raises an error for duplicate ATM ID' do
      atm_attributes = { id: 1, location: 'Uptown' }
      atm_attributes2 = { id: 1, location: 'Downtown' }
      controller.add_atm(atm_attributes) # First call should succeed

      expect { controller.add_atm(atm_attributes2) }.to output(/Error adding ATM/).to_stdout
    end

    it 'raises an error for empty location' do
      atm_attributes = { id: 2, location: '' }
      expect { controller.add_atm(atm_attributes) }.to output(/Error adding ATM/).to_stdout
    end
  end
  describe '#add_transaction_atm' do
    before do
      account_attributes = { id: 1, name: 'John Doe', job: 'Developer', email: 'adasa@dafa.com', address: '123 Main St', balance: 1000.0 }
      controller.add_account(account_attributes)
      atm_attributes = { id: 1, location: 'Downtown' }
      controller.add_atm(atm_attributes)
    end
    it 'adds a valid transaction ATM' do
      transaction_atm_attributes = { id: 1, account_id: 1, atm_id: 1, amount: 100.0, timestamp: Time.now, is_withdrawal: true }
      expect { controller.add_transaction_atm(transaction_atm_attributes) }.not_to raise_error
    end

    it 'raises an error for invalid transaction ATM' do
      transaction_atm_attributes = { id: nil, account_id: nil, atm_id: nil, amount: -50.0, timestamp: Time.now, is_withdrawal: true }
      expect { controller.add_transaction_atm(transaction_atm_attributes) }.to output(/Error adding transaction ATM/).to_stdout
    end

    it 'raises an error for withdrawal exceeding limit in 24 hours' do
      transaction_atm_attributes = { id: 2, account_id: 1, atm_id: 1, amount: 3000.0, timestamp: Time.now, is_withdrawal: true }
      transaction_atm_attributes2 = { id: 3, account_id: 1, atm_id: 1, amount: 3000.0, timestamp: Time.now, is_withdrawal: true }
      controller.add_transaction_atm(transaction_atm_attributes)
      expect { controller.add_transaction_atm(transaction_atm_attributes2) }.to output(/Error adding transaction ATM/).to_stdout
    end

    it 'raises an error for withdrawal exceeding 5000 limit' do
      transaction_atm_attributes = { id: 3, account_id: 1, atm_id: 1, amount: 6000.0, timestamp: Time.now, is_withdrawal: true }
      expect { controller.add_transaction_atm(transaction_atm_attributes) }.to output(/Error adding transaction ATM/).to_stdout
    end

    it 'raises an error for withdrawal with zero or negative amount' do
      transaction_atm_attributes = { id: 4, account_id: 1, atm_id: 1, amount: 0.0, timestamp: Time.now, is_withdrawal: true }
      expect { controller.add_transaction_atm(transaction_atm_attributes) }.to output(/Error adding transaction ATM/).to_stdout
    end
    it 'raises an error for transaction with nil ATM ID' do
      transaction_atm_attributes = { id: 5, account_id: 1, atm_id: nil, amount: 100.0, timestamp: Time.now, is_withdrawal: true }
      expect { controller.add_transaction_atm(transaction_atm_attributes) }.to output(/Error adding transaction ATM/).to_stdout
    end
    it 'raises an error for transaction with nil account ID' do
      transaction_atm_attributes = { id: 6, account_id: nil, atm_id: 1, amount: 100.0, timestamp: Time.now, is_withdrawal: true }
      expect { controller.add_transaction_atm(transaction_atm_attributes) }.to output(/Error adding transaction ATM/).to_stdout
    end
  end
  describe '#add_transaction_account' do
    before do
      account_attributes1 = { id: 1, name: 'John Doe', job: 'Developer', email: 'adrian@gmail.com', address: '123 Main St', balance: 1000.0 }
      account_attributes2 = { id: 2, name: 'Jane Doe', job: 'Designer', email: 'adrian@gmail.com', address: '456 Elm St', balance: 500.0 }
      controller.add_account(account_attributes1)
      controller.add_account(account_attributes2)
    end

    it 'adds a valid transaction account' do
      transaction_account_attributes = { id: 1, amount: 100.0, sender_id: 1, receiver_id: 2, timestamp: Time.now }
      expect { controller.add_transaction_account(transaction_account_attributes) }.not_to raise_error
    end

    it 'raises an error for invalid transaction account' do
      transaction_account_attributes = { id: nil, amount: -50.0, sender_id: nil, receiver_id: nil, timestamp: Time.now }
      expect { controller.add_transaction_account(transaction_account_attributes) }.to output(/Error adding transaction account/).to_stdout
    end

    it 'raises an error for transaction with insufficient funds' do
      transaction_account_attributes = { id: 2, amount: 2000.0, sender_id: 1, receiver_id: 2, timestamp: Time.now }
      expect { controller.add_transaction_account(transaction_account_attributes) }.to output(/Error adding transaction account/).to_stdout
    end

    it 'raises an error for transaction with zero or negative amount' do
      transaction_account_attributes = { id: 3, amount: 0.0, sender_id: 1, receiver_id: 2, timestamp: Time.now }
      expect { controller.add_transaction_account(transaction_account_attributes) }.to output(/Error adding transaction account/).to_stdout
    end

    it 'raises an error for transaction with nil sender ID' do
      transaction_account_attributes = { id: 4, amount: 100.0, sender_id: nil, receiver_id: 2, timestamp: Time.now }
      expect { controller.add_transaction_account(transaction_account_attributes) }.to output(/Error adding transaction account/).to_stdout
    end

    it 'raises an error for transaction with nil receiver ID' do
      transaction_account_attributes = { id: 5, amount: 100.0, sender_id: 1, receiver_id: nil, timestamp: Time.now }
      expect { controller.add_transaction_account(transaction_account_attributes) }.to output(/Error adding transaction account/).to_stdout
    end

    it 'raises an error for transaction with same sender and receiver ID' do
      transaction_account_attributes = { id: 6, amount: 100.0, sender_id: 1, receiver_id: 1, timestamp: Time.now }
      expect { controller.add_transaction_account(transaction_account_attributes) }.to output(/Error adding transaction account/).to_stdout
    end

    it 'raises an error for transaction with non-positive sender ID' do
      transaction_account_attributes = { id: 7, amount: 100.0, sender_id: -1, receiver_id: 2, timestamp: Time.now }
      expect { controller.add_transaction_account(transaction_account_attributes) }.to output(/Error adding transaction account/).to_stdout
    end

    it 'raises an error for transaction with non-positive receiver ID' do
      transaction_account_attributes = { id: 8, amount: 100.0, sender_id: 1, receiver_id: -2, timestamp: Time.now }
      expect { controller.add_transaction_account(transaction_account_attributes) }.to output(/Error adding transaction account/).to_stdout
    end
  end
  # Deletes
  describe '#delete_account' do
    before do
      account_attributes = { id: 1, name: 'John Doe', job: 'Developer', email: 'ada@gmail.com', address: '123 Main St', balance: 1000.0 }
      controller.add_account(account_attributes) # Add an account to delete
    end

    it 'deletes an existing account' do
      expect { controller.delete_account(1) }.not_to raise_error
      expect(controller.find_account_by_id(1)).to be_nil
    end

    it 'raises an error for non-existing account' do
      expect { controller.delete_account(999) }.to output(/Error deleting account/).to_stdout
    end

    it 'raises an error for nil account ID' do
      expect { controller.delete_account(nil) }.to output(/Error deleting account/).to_stdout
    end

    it 'raises an error for non-positive account ID' do
      expect { controller.delete_account(-1) }.to output(/Error deleting account/).to_stdout
    end
  end

  describe '#delete_atm' do
    before do
      atm_attributes = { id: 1, location: 'Downtown' }
      controller.add_atm(atm_attributes) # Add an ATM to delete
    end

    it 'deletes an existing ATM' do
      expect { controller.delete_atm(1) }.not_to raise_error
      expect(controller.find_atm_by_id(1)).to be_nil
    end

    it 'raises an error for non-existing ATM' do
      expect { controller.delete_atm(999) }.to output(/Error deleting ATM/).to_stdout
    end

    it 'raises an error for nil ATM ID' do
      expect { controller.delete_atm(nil) }.to output(/Error deleting ATM/).to_stdout
    end

    it 'raises an error for non-positive ATM ID' do
      expect { controller.delete_atm(-1) }.to output(/Error deleting ATM/).to_stdout
    end
  end

  # Retrieves by ID
  describe '#find_account_by_id' do
    before do
      account_attributes = { id: 1, name: 'John Doe', job: 'Developer', email: 'adrian@gmail.com', address: '123 Main St', balance: 1000.0 }
      controller.add_account(account_attributes) # Add an account to find
    end

    it 'finds an existing account by ID' do
      account = controller.find_account_by_id(1)
      expect(account).not_to be_nil
      expect(account.id).to eq(1)
      expect(account.name).to eq('John Doe')
    end

    it 'returns nil for non-existing account' do
      expect { controller.find_account_by_id(999) }.to output(/Error finding account/).to_stdout
    end

    it 'raises an error for nil account ID' do
      expect { controller.find_account_by_id(nil) }.to output(/Error finding account/).to_stdout
    end

    it 'raises an error for non-positive account ID' do
      expect { controller.find_account_by_id(-1) }.to output(/Error finding account/).to_stdout
    end
  end
  describe '#find_atm_by_id' do
    before do
      atm_attributes = { id: 1, location: 'Downtown' }
      controller.add_atm(atm_attributes) # Add an ATM to find
    end

    it 'finds an existing ATM by ID' do
      atm = controller.find_atm_by_id(1)
      expect(atm).not_to be_nil
      expect(atm.id).to eq(1)
      expect(atm.location).to eq('Downtown')
    end

    it 'returns nil for non-existing ATM' do
      expect { controller.find_atm_by_id(999) }.to output(/Error finding ATM/).to_stdout
    end

    it 'raises an error for nil ATM ID' do
      expect { controller.find_atm_by_id(nil) }.to output(/Error finding ATM/).to_stdout
    end

    it 'raises an error for non-positive ATM ID' do
      expect { controller.find_atm_by_id(-1) }.to output(/Error finding ATM/).to_stdout
    end
  end

  describe '#find_transaction_account_by_id' do
    before do
      account_attributes1 = { id: 1, name: 'John Doe', job: 'Developer', email: 'adi@gmail.com', address: '123 Main St', balance: 1000.0 }
      account_attributes2 = { id: 2, name: 'Jane Doe', job: 'Designer', email: 'ana@gmail.com', address: '456 Elm St', balance: 500.0 }
      controller.add_account(account_attributes1)
      controller.add_account(account_attributes2)
      transaction_account_attributes = { id: 1, amount: 100.0, sender_id: 1, receiver_id: 2, timestamp: Time.now }
      controller.add_transaction_account(transaction_account_attributes) # Add a transaction to find
    end

    it 'finds an existing transaction account by ID' do
      transaction = controller.find_transaction_account_by_id(1)
      expect(transaction).not_to be_nil
      expect(transaction.id).to eq(1)
      expect(transaction.amount).to eq(100.0)
      expect(transaction.sender_id).to eq(1)
      expect(transaction.receiver_id).to eq(2)
    end

    it 'returns nil for non-existing transaction account' do
      expect { controller.find_transaction_account_by_id(999) }.to output(/Error finding transaction account/).to_stdout
    end

    it 'raises an error for nil transaction account ID' do
      expect { controller.find_transaction_account_by_id(nil) }.to output(/Error finding transaction account/).to_stdout
    end

    it 'raises an error for non-positive transaction account ID' do
      expect { controller.find_transaction_account_by_id(-1) }.to output(/Error finding transaction account/).to_stdout
    end
  end
  describe '#find_transaction_atm_by_id' do
    before do
      account_attributes = { id: 1, name: 'John Doe', job: 'Developer', email: 'adi@gmail.com', address: '123 Main St', balance: 1000.0 }
      controller.add_account(account_attributes)
      atm_attributes = { id: 1, location: 'Downtown' }
      controller.add_atm(atm_attributes)
      transaction_atm_attributes = { id: 1, account_id: 1, atm_id: 1, amount: 100.0, timestamp: Time.now, is_withdrawal: true }
      controller.add_transaction_atm(transaction_atm_attributes) # Add a transaction ATM to find
    end

    it 'finds an existing transaction ATM by ID' do
      transaction = controller.find_transaction_atm_by_id(1)
      expect(transaction).not_to be_nil
      expect(transaction.id).to eq(1)
      expect(transaction.amount).to eq(100.0)
      expect(transaction.account_id).to eq(1)
      expect(transaction.atm_id).to eq(1)
    end

    it 'returns nil for non-existing transaction ATM' do
      expect { controller.find_transaction_atm_by_id(999) }.to output(/Error finding transaction ATM/).to_stdout
    end

    it 'raises an error for nil transaction ATM ID' do
      expect { controller.find_transaction_atm_by_id(nil) }.to output(/Error finding transaction ATM/).to_stdout
    end

    it 'raises an error for non-positive transaction ATM ID' do
      expect { controller.find_transaction_atm_by_id(-1) }.to output(/Error finding transaction ATM/).to_stdout
    end
  end
  # Updates
  describe '#update_account' do
    before do
      account_attributes = { id: 1, name: 'John Doe', job: 'Developer', email: 'ada@gmail.com', address: '123 Main St', balance: 1000.0 }
      controller.add_account(account_attributes) # Add an account to update
    end

    it 'updates an existing account' do
      updated_attributes = { name: 'John Smith', job: 'Senior Developer', email: 'adi@gmail.com', address: '123 Main St', balance: 1200.0 }

      expect { controller.update_account(1, updated_attributes) }.not_to raise_error
      account = controller.find_account_by_id(1)
      expect(account.name).to eq('John Smith')
      expect(account.job).to eq('Senior Developer')
      expect(account.email).to eq('adi@gmail.com')
      expect(account.address).to eq('123 Main St')
      expect(account.balance).to eq(1200.0)
    end

    it 'raises an error for non-existing account' do
      updated_attributes = { name: 'Nonexistent', job: 'Tester', email: 'adi@gmail.com', address: '123 Main St', balance: 1000.0 }
      expect { controller.update_account(999, updated_attributes) }.to output(/Error updating account/).to_stdout
    end

    it 'raises an error for nil account ID' do
      updated_attributes = { name: 'John Smith', job: 'Senior Developer', email: 'adi@gmail.com', address: '123 Main St', balance: 1200.0 }
      expect { controller.update_account(nil, updated_attributes) }.to output(/Error updating account/).to_stdout
    end

    it 'raises an error for non-positive account ID' do
      updated_attributes = { name: 'John Smith', job: 'Senior Developer', email: 'adi@gmail.com', address: '123 Main St', balance: 1200.0 }
      expect { controller.update_account(-1, updated_attributes) }.to output(/Error updating account/).to_stdout
    end

    it 'raises an error for invalid email format' do
      updated_attributes = { name: 'John Smith', job: 'Senior Developer', email: 'invalid-email', address: '123 Main St', balance: 1200.0 }
      expect { controller.update_account(1, updated_attributes) }.to output(/Error updating account/).to_stdout
    end

    it 'raises an error for invalid name format' do
      updated_attributes = { name: 'John123', job: 'Senior Developer', email: 'adi@gmail.com', address: '123 Main St', balance: 1200.0 }
      expect { controller.update_account(1, updated_attributes) }.to output(/Error updating account/).to_stdout
    end

    it 'raises an error for invalid job format' do
      updated_attributes = { name: 'John Smith', job: 'Senior123', email: 'adi@gmail.com', address: '123 Main St', balance: 1200.0 }
      expect { controller.update_account(1, updated_attributes) }.to output(/Error updating account/).to_stdout
    end
  end
  # Retrieves
  describe '#all_accounts' do
    before do
      account_attributes1 = { id: 1, name: 'John Doe', job: 'Developer', email: 'adir@gmail.com', address: '123 Main St', balance: 1000.0 }
      account_attributes2 = { id: 2, name: 'Jane Doe', job: 'Designer', email: 'adsa@gmail.com', address: '456 Elm St', balance: 500.0 }
      controller.add_account(account_attributes1)
      controller.add_account(account_attributes2)
    end

    it 'returns all accounts' do
      accounts = controller.all_accounts
      expect(accounts.size).to eq(2)
      expect(accounts.map(&:id)).to contain_exactly(1, 2)
      expect(accounts.map(&:name)).to contain_exactly('John Doe', 'Jane Doe')
    end
    it 'returns an empty array when no accounts exist' do
      controller.delete_account(1)
      controller.delete_account(2)
      accounts = controller.all_accounts
      expect(accounts).to be_empty
    end
  end
  describe '#all_atms' do
    before do
      atm_attributes1 = { id: 1, location: 'Downtown' }
      atm_attributes2 = { id: 2, location: 'Uptown' }
      controller.add_atm(atm_attributes1)
      controller.add_atm(atm_attributes2)
    end

    it 'returns all ATMs' do
      atms = controller.all_atms
      expect(atms.size).to eq(2)
      expect(atms.map(&:id)).to contain_exactly(1, 2)
      expect(atms.map(&:location)).to contain_exactly('Downtown', 'Uptown')
    end

    it 'returns an empty array when no ATMs exist' do
      controller.delete_atm(1)
      controller.delete_atm(2)
      atms = controller.all_atms
      expect(atms).to be_empty
    end
  end

  describe '#all_transaction_accounts' do
    before do
      account_attributes1 = { id: 1, name: 'John Doe', job: 'Developer', email: 'adiad@gmail.com', address: '123 Main St', balance: 1000.0 }
      account_attributes2 = { id: 2, name: 'Jane Doe', job: 'Designer', email: 'adavs@gmail.com', address: '456 Elm St', balance: 500.0 }
      controller.add_account(account_attributes1)
      controller.add_account(account_attributes2)
      transaction_account_attributes1 = { id: 1, amount: 100.0, sender_id: 1, receiver_id: 2, timestamp: Time.now }
      transaction_account_attributes2 = { id: 2, amount: 200.0, sender_id: 2, receiver_id: 1, timestamp: Time.now }
      controller.add_transaction_account(transaction_account_attributes1)
      controller.add_transaction_account(transaction_account_attributes2)
    end
    it 'returns all transaction accounts' do
      transactions = controller.all_transactions_account
      expect(transactions.size).to eq(2)
      expect(transactions.map(&:id)).to contain_exactly(1, 2)
      expect(transactions.map(&:amount)).to contain_exactly(100.0, 200.0)
      expect(transactions.map(&:sender_id)).to contain_exactly(1, 2)
      expect(transactions.map(&:receiver_id)).to contain_exactly(2, 1)
    end
  end
  describe '#all_transaction_atm' do
    before do
      account_attributes = { id: 1, name: 'John Doe', job: 'Developer', email: 'adi@gmail.com', address: '123 Main St', balance: 1000.0 }
      controller.add_account(account_attributes)
      atm_attributes = { id: 1, location: 'Downtown' }
      controller.add_atm(atm_attributes)
      transaction_atm_attributes = { id: 1, account_id: 1, atm_id: 1, amount: 100.0, timestamp: Time.now, is_withdrawal: true }
      controller.add_transaction_atm(transaction_atm_attributes)
    end

    it 'returns all transaction ATMs' do
      transactions = controller.all_transactions_atm
      expect(transactions.size).to eq(1)
      expect(transactions.map(&:id)).to contain_exactly(1)
      expect(transactions.map(&:amount)).to contain_exactly(100.0)
      expect(transactions.map(&:account_id)).to contain_exactly(1)
      expect(transactions.map(&:atm_id)).to contain_exactly(1)
      expect(transactions.map(&:is_withdrawal)).to contain_exactly(true)
    end
  end
end
