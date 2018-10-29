class Customer
  attr_accessor :first_name
  attr_reader   :id
  def initialize(cust_data)
    @id         = cust_data[:id]
    @first_name = cust_data[:first_name]
  end
end
