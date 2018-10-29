class Customer
  attr_reader   :id
  def initialize(cust_data)
    @id      = cust_data[:id]
  end
end
