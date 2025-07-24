class UI
  def initialize(controller)
    @controller = controller
  end

  def prompt(msg)
    print "#{msg}: "
    gets.chomp
  end

  def run
    loop do
      puts "\nBank ATM Management"
      puts '1. Create Account'
      puts '2. Create ATM'
      puts '3. Deposit Money'
      puts '4. Withdraw Money'
      puts '5. Show Account Info'
      puts '6. Show All Accounts'
      puts '7. Send Money to Another Account'
      puts '8. Exit'
      choice = prompt('Choose an option').to_i

      case choice
      when 1
        create_account
      when 2
        create_atm
      when 3
        deposit_money
      when 4
        withdraw_money
      when 5
        show_account_info
      when 6
        show_all_accounts
      when 7
        send_money
      when 8
        puts 'Exiting...'
        break
      else
        puts 'Invalid option, please try again.'
      end
    end
  end

  def create_account
    id = prompt('Enter account ID')
    name = prompt('Enter account holder name')
    job = prompt('Enter job title')
    email = prompt('Enter email address')
    address = prompt('Enter address')
    balance = prompt('Enter initial balance').to_f

    account_attributes = {
      id: id.to_i,
      name: name,
      job: job,
      email: email,
      address: address,
      balance: balance.to_f
    }
    @controller.add_account(account_attributes)
  end

  def create_atm
    id = prompt('Enter ATM ID').to_i
    location = prompt('Enter ATM location')

    atm_attributes = {
      id: id.to_i,
      location: location
    }

    @controller.add_atm(atm_attributes)
  end

  def deposit_money
    account_id = prompt('Enter account ID to deposit money into')
    amount = prompt('Enter amount to deposit')
    atm_id = prompt('Enter ATM ID')

    transaction_atm_attributes = {
      id: Time.now.to_i, # Using current time as a simple unique ID
      amount: amount.to_f,
      account_id: account_id.to_i,
      atm_id: atm_id.to_i,
      timestamp: Time.now
    }

    @controller.add_transaction_atm(transaction_atm_attributes)
  end

  def withdraw_money
    account_id = prompt('Enter account ID to withdraw money from')
    amount = prompt('Enter amount to withdraw')
    atm_id = prompt('Enter ATM ID')

    transaction_atm_attributes = {
      id: Time.now.to_i, # Using current time as a simple unique ID
      amount: amount.to_f,
      account_id: account_id.to_i,
      atm_id: atm_id.to_i,
      timestamp: Time.now,
      is_withdrawal: true
    }

    @controller.add_transaction_atm(transaction_atm_attributes)
  end

  def show_account_info
    account_id = prompt('Enter account ID to view info')
    account = @controller.find_account_by_id(account_id.to_i)

    if account
      puts "Account ID: #{account.id}"
      puts "Name: #{account.name}"
      puts "Job: #{account.job}"
      puts "Email: #{account.email}"
      puts "Address: #{account.address}"
      puts "Balance: #{account.balance}"
    else
      puts 'Account not found.'
    end
  end

  def send_money
    sender_id = prompt('Enter sender account ID')
    receiver_id = prompt('Enter receiver account ID')
    amount = prompt('Enter amount to send')

    transaction_account_attributes = {
      id: Time.now.to_i, # Using current time as a simple unique ID
      sender_id: sender_id.to_i,
      reciver_id: receiver_id.to_i,
      amount: amount.to_f,
      timestamp: Time.now
    }

    @controller.add_transaction_account(transaction_account_attributes)
  end

  def show_all_accounts
    accounts = @controller.all_accounts

    if accounts.empty?
      puts 'No accounts found.'
    else
      accounts.each do |account|
        puts "Account ID: #{account.id}, Name: #{account.name}, Balance: #{account.balance}"
      end
    end
  end
end
