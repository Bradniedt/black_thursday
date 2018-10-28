require_relative '../lib/find_methods'

class InvoiceItemRepository
  include FindMethods
  def initialize(invoice_items)
    @collection = invoice_items
  end

end
