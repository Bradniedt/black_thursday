require_relative '../lib/find_methods'
require_relative '../lib/invoice_item'
require 'time'

class InvoiceItemRepository
  include FindMethods

  def initialize(invoice_items)
    @collection = invoice_items
  end

  def find_all_by_item_id(item_id)
    @collection.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @collection.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def create(attributes)
    highest = @collection.max_by do |invoice_item|
      invoice_item.id.to_i
    end
    new_id = highest.id.to_i + 1
    new_object = InvoiceItem.new( { id: new_id,
                                    item_id: attributes[:item_id].to_i,
                                    invoice_id: attributes[:invoice_id].to_i,
                                    quantity: attributes[:quantity].to_i,
                                    unit_price: attributes[:unit_price],
                                    created_at: Time.now.to_s,
                                    updated_at: Time.now.to_s
                                  } )
    @collection << new_object
    new_object
  end

end
