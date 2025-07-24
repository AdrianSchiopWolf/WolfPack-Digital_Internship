class TransactionAccount
  attr_accessor :id, :amount, :date, :sender_id, :reciver_id

  def initialize(id, amount, sender_id, reciver_id, timestamp)
    @id = id
    @amount = amount
    @date = date
    @sender_id = sender_id
    @reciver_id = reciver_id
    @timestamp = timestamp
  end

  def to_s
    "Transaction ID: #{@id}, Amount: #{@amount}, Date: #{@date}, Account ID: #{@sender_id}, ATM ID: #{@reciver_id}"
  end
end
