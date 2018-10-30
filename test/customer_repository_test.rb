require_relative './helper'
require_relative '../lib/sales_engine'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'
class CustomerRepositoryTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv( {
                                :items          => './data/items.csv',
                                :merchants      => './data/merchants.csv',
                                :invoices       => './data/invoices.csv',
                                :invoice_items  => './data/invoice_items.csv',
                                :transactions   => './data/transactions.csv',
                                :customers      => './data/customers.csv'
                                } )
    @customer = se.customers
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @customer
  end

  def test_it_can_get_all_customers
    assert_equal 1000, @customer.all.count
  end

  def test_it_can_find_by_id
    assert_instance_of Customer, @customer.find_by_id(3)
  end
end
