require_relative '../lib/find_methods'
require_relative '../lib/invoice_item'
require 'time'
require 'bigdecimal'

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

  def update(id, attributes)
    being_updated = find_by_id(id)
    if being_updated
      if attributes.has_key?(:quantity)
        being_updated.quantity = attributes[:quantity].to_i
      end
      if attributes.has_key?(:unit_price)
        new_price = big_decimal_converter(attributes[:unit_price])
        being_updated.unit_price = new_price
      end
    end
  end

  def big_decimal_converter(price)
    significant_digits = price.to_s.length
    number = price.to_f / 100
    BigDecimal.new(number, significant_digits)
  end

end
