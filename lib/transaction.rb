class Transaction
  attr_reader   :id,
                :invoice_id
  def initialize(tran_data)
    @id         = tran_data[:id]
    @invoice_id = tran_data[:invoice_id]
  end
end
