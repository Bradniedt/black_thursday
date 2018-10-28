require_relative '../lib/find_methods'

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
end
