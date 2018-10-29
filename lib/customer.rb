class Customer
  attr_accessor :first_name,
                :last_name
  attr_reader   :id
  def initialize(cust_data)
    @id         = cust_data[:id]
    @first_name = cust_data[:first_name]
    @last_name  = cust_data[:last_name]
  end
end
