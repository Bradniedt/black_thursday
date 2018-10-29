class Transaction
  attr_reader   :id
  def initialize(tran_data)
    @id     = tran_data[:id]
  end
end
