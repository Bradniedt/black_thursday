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
        :invoice_items  => './data/invoice_items.csv'
                                } )
    @invoice_i = se.invoice_items
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @invoice_i
  end
end
