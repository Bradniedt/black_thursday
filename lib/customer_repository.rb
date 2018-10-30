require_relative '../lib/find_methods'
require_relative '../lib/customer'
require 'time'
class CustomerRepository
  include FindMethods
  def initialize(customers)
    @collection = customers
  end
end
