class Account
  attr_accessor :id, :balance, :name, :job, :email, :address

  def initialize(id, balance, name, job, email, address)
    @id = id
    @balance = balance
    @name = name
    @job = job
    @email = email
    @address = address
  end

  def to_s
    "Account ID: #{@id}, Name: #{@name}, Job: #{@job}, Email: #{@email}, Address: #{@address}, Balance: #{@balance}"
  end
end
