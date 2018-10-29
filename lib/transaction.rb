class Transaction
  attr_accessor :credit_card_number,
                :credit_card_expiration_date
  attr_reader   :id,
                :invoice_id
  def initialize(tran_data)
    @id         = tran_data[:id]
    @invoice_id = tran_data[:invoice_id]
    @credit_card_number = tran_data[:credit_card_number]
    @credit_card_expiration_date = tran_data[:credit_card_expiration_date]
    
  end
end
