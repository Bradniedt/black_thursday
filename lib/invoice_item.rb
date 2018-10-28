class InvoiceItem
  attr_reader     :id
  def initialize(invoice_data)
    @id = invoice_data[:id]
  end
end
