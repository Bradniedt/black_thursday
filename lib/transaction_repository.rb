require_relative '../lib/find_methods'
require_relative '../lib/transaction'
require 'time'
class TransactionRepository
  include FindMethods
  def initialize(transactions)
    @collection = transactions
  end
end
