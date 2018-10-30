require 'time'
class Customer
  attr_accessor :first_name,
                :last_name,
                :updated_at
  attr_reader   :id,
                :created_at
  def initialize(cust_data)
    @id         = cust_data[:id]
    @first_name = cust_data[:first_name]
    @last_name  = cust_data[:last_name]
    @created_at = Time.parse(cust_data[:created_at])
    @updated_at = Time.parse(cust_data[:updated_at])
  end
end
