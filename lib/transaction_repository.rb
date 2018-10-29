require_relative '../lib/find_methods'
require_relative '../lib/transaction'
require 'time'
class TransactionRepository
  include FindMethods
  def initialize(transactions)
    @collection = transactions
  end

  def find_all_by_invoice_id(id)
    @collection.find_all do |transaction|
      transaction.invoice_id == id
    end
  end
end
