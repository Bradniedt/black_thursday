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

  def find_all_by_result(result)
    @collection.find_all do |transaction|
      transaction.result == result
    end
  end

  def create(attributes)
    highest = @collection.max_by do |transaction|
      transaction.id.to_i
    end
    new_id = highest.id.to_i + 1
    new_object = Transaction.new( {
      id: new_id,
      invoice_id: attributes[:invoice_id].to_i,
      credit_card_number: attributes[:credit_card_number].to_i,
      credit_card_expiration_date: attributes[:credit_card_expiration_date].to_i,
      result: attributes[:result],
      created_at: Time.now.to_s,
      updated_at: Time.now.to_s
                                   } )
    @collection << new_object
    new_object
  end

  def update(id, attributes)
    being_updated = find_by_id(id)
    if being_updated
      if attributes.key?(:credit_card_number)
        being_updated.credit_card_number = attributes[:credit_card_number].to_i
      end
      if attributes.key?(:credit_card_expiration_date)
        being_updated.credit_card_expiration_date = attributes[:credit_card_expiration_date]
      end
      if attributes.key?(:result)
        being_updated.result = attributes[:result]
      end
    end
  end
end
