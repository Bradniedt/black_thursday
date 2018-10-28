class InvoiceItem
  attr_reader     :id,
                  :item_id
  def initialize(invoice_data)
    @id = invoice_data[:id]
    @item_id = invoice_data[:item_id]
  end
end
