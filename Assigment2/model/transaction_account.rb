class TransactionAccount
  attr_accessor :id, :amount, :sender_id, :receiver_id, :timestamp

  def initialize(id, amount, sender_id, receiver_id, timestamp)
    @id = id
    @amount = amount
    @sender_id = sender_id
    @receiver_id = receiver_id
    @timestamp = timestamp
  end

  def to_s
    "Transaction ID: #{@id}, Amount: #{@amount}, Account ID: #{@sender_id}, ATM ID: #{@receiver_id}, Timestamp: #{@timestamp}"
  end
end
