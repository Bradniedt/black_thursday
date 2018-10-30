require_relative './helper'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
class MerchantRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv( {
      :items              => './data/items.csv',
      :merchants          => './data/merchants.csv',
      :invoices           => './data/invoices.csv',
      :invoice_items      => './data/invoice_items.csv',
      :transactions       => './data/transactions.csv',
      :customers          => './data/customers.csv'
                             } )
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_can_return_array_of_all_merchant_instances
    assert_equal 475, @se.merchants.all.count
  end

  def test_can_find_by_id
    assert_instance_of Merchant, @se.merchants.find_by_id(12335971)
  end

  def test_it_can_find_by_name
    assert_instance_of Merchant, @se.merchants.find_by_name('GoldenRayPress')
  end

  def test_it_can_find_all_by_name
    assert_equal [], @se.merchants.find_all_by_name('Leprechauns')
    assert_equal 1, @se.merchants.find_all_by_name('Golden').count
  end

  def test_it_can_create_merchant_with_attribute
    assert_instance_of Merchant, @se.merchants.create({name:'SalsSidekicks'})
    assert_equal 'SalsSidekicks', @se.merchants.all.last.name
    assert_equal 12337412, @se.merchants.all.last.id
  end

  def test_it_can_update_merchant_attributes
    @se.merchants.update(12334135, {name: 'SilverSunPress'})
    assert_equal 'SilverSunPress', @se.merchants.find_by_id(12334135).name
  end

  def test_can_delete_id
    assert @se.merchants.all.any? { |merchant| merchant.id == 12337411 }
    @se.merchants.delete(12337411)
    refute @se.merchants.all.any? { |merchant| merchant.id == 12337411 }
  end
end
