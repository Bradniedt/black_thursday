require_relative './helper'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/sales_engine'
class ItemRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv( {
        :items          => './data/items.csv',
        :merchants      => './data/merchants.csv',
        :invoices       => './data/invoices.csv',
        :invoice_items  => './data/invoice_items.csv',
        :transactions   => './data/transactions.csv',
        :customers      => './data/customers.csv'
                             } )
    @time_now = Time.now
    @updated_time = Time.now
  end

  def test_it_exists
    assert_instance_of ItemRepository, @se.items
  end

  def test_it_can_return_array_of_all_items
    assert_equal 1367, @se.items.all.count
  end

  def test_it_can_find_by_id
    assert_instance_of Item, @se.items.find_by_id(263399263)
  end

  def test_it_can_find_by_name
    assert_instance_of Item, @se.items.find_by_name('Oak Bowl')
  end

  def test_it_can_find_all_by_name
    assert_equal [], @se.items.find_all_by_name('AaronBrooksRoberts')
    assert_equal 3, @se.items.find_all_by_name('Oak').count
  end

  def test_it_can_find_all_with_decription
    assert_equal [], @se.items.find_all_with_description('bradleyniedt')
    assert_equal 4, @se.items.find_all_with_description('ear wire').count
  end

  def test_it_can_find_all_by_price
    assert_equal [], @se.items.find_all_by_price(42737)
    assert_equal 7, @se.items.find_all_by_price(400).count
  end

  def test_it_can_find_all_by_price_in_range
    assert_equal [], @se.items.find_all_by_price_in_range(0.01..0.02)
    assert_equal 110, @se.items.find_all_by_price_in_range(3.00..6.00).count
  end

  def test_it_can_find_all_by_merchant_id
    assert_equal [], @se.items.find_all_by_merchant_id(12345678)
    assert_equal 6, @se.items.find_all_by_merchant_id(12334185).count
  end


  def test_it_can_create_new_item
    actual = @se.items.create({ name: 'LeahKathrynMiller',
                          description: 'fun',
                          unit_price: '360',
                          created_at: @time_now,
                          updated_at: @updated_time,
                          merchant_id: '73922533'
                          })
    assert_instance_of Item, actual
    assert_equal 263567475, @se.items.all.last.id
  end

  def test_it_can_update_attributes
    @se.items.update(263397313, { name: 'Super Cool Stuff',
                             description: 'This is really cool',
                             unit_price: '1000000'})
    assert_equal 'Super Cool Stuff', @se.items.find_by_id(263397313).name
    assert_equal 'This is really cool', @se.items.find_by_id(263397313).description
    assert_equal '1000000', @se.items.find_by_id(263397313).unit_price
  end

  def test_it_can_delete_an_item
    @se.items.create( {  name: 'LeahKathrynMiller',
                  description: 'fun',
                  unit_price: '360',
                  created_at: @time_now,
                  updated_at: @updated_time,
                  merchant_id: '73922533'
              } )
    @se.items.delete(263567475)
    refute @se.items.all.any? { |item| item.id == 263567475 }
  end
end
