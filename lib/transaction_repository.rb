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

  def find_all_by_credit_card_number(cc_number)
    @collection.find_all do |transaction|
      transaction.credit_card_number == cc_number
    end
  end
  
end
