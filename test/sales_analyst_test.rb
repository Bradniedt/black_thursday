require_relative './helper'
require 'time'
require_relative '../lib/sales_engine'
class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv( {
        :items          => './data/items.csv',
        :merchants      => './data/merchants.csv',
        :invoices       => './data/invoices.csv',
        :invoice_items  => './data/invoice_items.csv',
        :transactions   => './data/transactions.csv',
        :customers      => './data/customers.csv'
                                } )
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @se.analyst
  end

  def test_it_can_return_average_items_per_merchant
    assert_equal 2.88, @se.analyst.average_items_per_merchant
  end

  def test_it_can_count_total_number_of_items
    assert_equal 1367.00, @se.analyst.count_all_items
  end

  def test_it_can_count_all_merchants
    assert_equal 475.00, @se.analyst.count_all_merchants
  end

  def test_it_can_calculate_standard_deviation
    assert_equal 3.26, @se.analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_can_return_merchants_with_high_count
    assert_equal 52, @se.analyst.merchants_with_high_item_count.count
  end

  def test_it_can_return_average_item_price_for_a_merchant
    assert_equal 16.66, @se.analyst.average_item_price_for_merchant(12334105)
  end

  def test_it_can_return_average_price_for_all_merchants
    assert_equal 350.29, @se.analyst.average_average_price_per_merchant
  end

  def test_can_record_standard_deviation_for_item_price
    assert_equal 2899.93, @se.analyst.price_standard_deviation
  end

  def test_it_can_return_golden_items
    assert_equal 5, @se.analyst.golden_items.length
  end

  def test_it_can_find_average_invoices_per_merchant
    assert_equal 10.49, @se.analyst.average_invoices_per_merchant
  end

  def test_it_can_return_invoices_per_merchant_standard_deviation
    assert_equal 3.29, @se.analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_return_top_merchants_by_invoice_count
    assert_equal 12, @se.analyst.top_merchants_by_invoice_count.count
  end

  def test_it_can_return_bottom_merchants_by_invoice_count
    assert_equal 4, @se.analyst.bottom_merchants_by_invoice_count.count
  end

  def test_it_can_convert_date_to_days
    assert_equal 'Monday', @se.analyst.date_to_days('2018-10-29')
  end

  def test_it_can_find_average_day_value
    assert_equal 712.14, @se.analyst.average_days
  end

  def test_it_can_find_standard_deviation_for_invoice_created_at
    assert_equal 18.07, @se.analyst.invoice_days_standard_deviation
  end

  def test_it_can_count_top_days_by_invoice
    assert_equal ['Wednesday'], @se.analyst.top_days_by_invoice_count
  end

  def test_it_can_calculate_percentage_of_all_statuses
    assert_equal 29.55, @se.analyst.invoice_status(:pending)
    assert_equal 56.95, @se.analyst.invoice_status(:shipped)
    assert_equal 13.5, @se.analyst.invoice_status(:returned)
  end

  def test_can_find_if_invoice_is_paid_in_full
    assert_equal true, @se.analyst.invoice_paid_in_full?(2179)
  end

  def test_it_can_return_an_invoice_total
    assert_equal 31075.11, @se.analyst.invoice_total(2179)
  end

  def test_it_can_find_total_revenue_by_date
    date = Time.parse("2009-02-07")
    assert_equal 21067.77, @se.analyst.total_revenue_by_date(date)
  end

  # def test_it_can_separate_sucessful_transactions_by_customer
  #   assert_equal 835, @se.analyst.successful_transactions_by_customer.count
  # end
  #
  # def test_it_can_return_top_buyers
  #   assert_equal 5, @se.analyst.top_buyers(5).length
  #   assert_equal 313, @se.analyst.top_buyers(5).first.id
  #   assert_equal 478, @se.analyst.top_buyers(5).last.id
  # end
  #
  # def test_it_can_find_top_merchant_for_customer
  #   assert_equal "merchant", @se.analyst.top_merchant_for_customer(100)
  # end
end
