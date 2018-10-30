require_relative './helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def setup
    @invoice_item = InvoiceItem.new({
                    :id => 6,
                    :item_id => 7,
                    :invoice_id => 8,
                    :quantity => 1,
                    :unit_price => BigDecimal.new(10.99, 4),
                    :created_at => '2016-01-11 09:34:06 UTC',
                    :updated_at => '2007-06-04 21:35:10 UTC'
                                    })
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_item
  end

  def test_it_returns_id
    assert_equal 6, @invoice_item.id
  end

  def test_it_returns_item_id
    assert_equal 7, @invoice_item.item_id
  end

  def test_it_returns_invoice_id
    assert_equal 8, @invoice_item.invoice_id
  end

  def test_it_returns_quantity
    assert_equal 1, @invoice_item.quantity
  end

  def test_it_can_return_unit_price
    assert_equal 10.99, @invoice_item.unit_price
  end

  def test_it_can_update_created_at
    assert_equal '2016-01-11 09:34:06 UTC', @invoice_item.created_at.to_s
  end

  def test_it_can_return_updated_at
    assert_equal '2007-06-04 21:35:10 UTC', @invoice_item.updated_at.to_s
  end

  def test_it_can_return_unit_price_to_dollars
    assert_equal 10.99, @invoice_item.unit_price_to_dollars
  end
end
