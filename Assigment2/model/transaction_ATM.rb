class TransactionATM
  attr_accessor :id, :account_id, :atm_id, :amount, :timestamp, :is_withdrawal

  def initialize(id, account_id, atm_id, amount, timestamp, is_withdrawal = false)
    @id = id
    @account_id = account_id
    @atm_id = atm_id
    @amount = amount
    @timestamp = timestamp
    @is_withdrawal = is_withdrawal
  end

  def to_s
    "Transaction ID: #{@id}, Account ID: #{@account_id}, ATM ID: #{@atm_id}, Amount: #{@amount}, Type: #{@transaction_type}, Timestamp: #{@timestamp}
    #{@is_withdrawal ? '(Withdrawal)' : '(Deposit)'}"
  end
end
