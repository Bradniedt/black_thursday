require_relative './helper'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'
class MerchantRepositoryTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv( {
        :items          => './data/items.csv',
        :merchants      => './data/merchants.csv',
        :invoices       => './data/invoices.csv',
        :invoice_items  => './data/invoice_items.csv',
        :transactions   => './data/transactions.csv',
        :customers      => './data/customers.csv'
                                } )
    @invoice_i = se.invoice_items
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @invoice_i
  end

  def test_it_can_get_all_invoice_items
    assert_equal 21_830, @invoice_i.all.count
  end

  def test_it_can_find_by_id
    assert_instance_of InvoiceItem, @invoice_i.find_by_id(1)
  end

  def test_it_can_find_all_by_item_id
    assert_equal 164, @invoice_i.find_all_by_item_id(263519844).count
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal 8, @invoice_i.find_all_by_invoice_id(1).count
  end

  def test_it_can_create_a_new_invoice_item
    attributes = {
      item_id: '263546142',
      invoice_id: '4',
      quantity: '3',
      unit_price: '37333'
                 }
    assert_instance_of InvoiceItem, @invoice_i.create(attributes)
  end

  def test_it_can_update_an_invoice_item
    attributes = {
      quantity: '5',
      unit_price: '1099'
                 }
    @invoice_i.update(30, attributes)
    assert_equal 5, @invoice_i.find_by_id(30).quantity
    assert_equal 10.99, @invoice_i.find_by_id(30).unit_price_to_dollars
  end

  def test_it_can_delete_an_invoice_item
    attributes = {
      item_id: '263546142',
      invoice_id: '4',
      quantity: '3',
      unit_price: '37333'
                 }
    @invoice_i.create(attributes)
    @invoice_i.delete(4)
    assert_equal 21_830, @invoice_i.all.count
  end
end
