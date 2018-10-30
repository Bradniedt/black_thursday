require_relative '../lib/find_methods'
require_relative '../lib/customer'
require 'time'
class CustomerRepository
  include FindMethods
  def initialize(customers)
    @collection = customers
  end

  def find_all_by_first_name(f_name)
    @collection.find_all do |customer|
      customer.first_name == f_name
    end
  end

  def find_all_by_last_name(l_name)
    @collection.find_all do |customer|
      customer.last_name == l_name
    end
  end
end
