class InvoiceItem
  attr_reader     :id,
                  :item_id,
                  :invoice_id,
                  :quantity,
                  :unit_price,
                  :created_at,
                  :updated_at
  def initialize(invoice_data)
    @id         = invoice_data[:id]
    @item_id    = invoice_data[:item_id]
    @invoice_id = invoice_data[:invoice_id]
    @quantity   = invoice_data[:quantity]
    @unit_price = invoice_data[:unit_price]
    @created_at = invoice_data[:created_at]
    @updated_at = invoice_data[:updated_at]
  end
end
