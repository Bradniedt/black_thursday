class InvoiceItem
  attr_reader     :id,
                  :item_id,
                  :invoice_id
  def initialize(invoice_data)
    @id = invoice_data[:id]
    @item_id = invoice_data[:item_id]
    @invoice_id = invoice_data[:invoice_id]
  end
end
