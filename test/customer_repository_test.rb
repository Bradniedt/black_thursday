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

  def test_it_can_find_all_by_first_name
    assert_equal 1, @customer.find_all_by_first_name('Joey').count
  end

  def test_it_can_find_all_by_last_name
    assert_equal 2, @customer.find_all_by_last_name('Toy').count
  end

  def test_it_can_create_a_new_customer
    attributes = { first_name: 'Michael',
                   last_name: 'Jordan' }
    assert_instance_of Customer, @customer.create(attributes)
  end

  def test_it_can_update_a_customer
    @customer.update(1, { first_name: 'Beef',
                          last_name:  'Jerky' } )
    assert_equal 'Beef', @customer.find_by_id(1).first_name
    assert_equal 'Jerky', @customer.find_by_id(1).last_name
  end

  def test_it_can_delete_a_customer
    @customer.delete(30)
    assert_equal 999, @customer.all.count
  end
end
