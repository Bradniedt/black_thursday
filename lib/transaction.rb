require 'time'
class Transaction
  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at
  attr_reader   :id,
                :invoice_id,
                :created_at
  def initialize(tran_data)
    @id         = tran_data[:id]
    @invoice_id = tran_data[:invoice_id]
    @credit_card_number = tran_data[:credit_card_number]
    @credit_card_expiration_date = tran_data[:credit_card_expiration_date].rjust(4, "0")
    @result     = tran_data[:result]
    @created_at = Time.parse(tran_data[:created_at])
    @updated_at = Time.parse(tran_data[:updated_at])
  end
end
