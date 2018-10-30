require 'time'
class InvoiceItem
  attr_reader     :id,
                  :item_id,
                  :invoice_id,
                  :created_at
  attr_accessor   :quantity,
                  :unit_price,
                  :updated_at
  def initialize(invoice_data)
    @id         = invoice_data[:id]
    @item_id    = invoice_data[:item_id]
    @invoice_id = invoice_data[:invoice_id]
    @quantity   = invoice_data[:quantity]
    @unit_price = invoice_data[:unit_price]
    @created_at = Time.parse(invoice_data[:created_at])
    @updated_at = Time.parse(invoice_data[:updated_at])
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
