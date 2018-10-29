require_relative './helper'
require_relative '../lib/transaction'
class TransationTest < Minitest::Test
  def setup
    @t = Transaction.new({:id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => Time.now,
                          :updated_at => Time.now
                          })
  end

  def test_it_exists
    assert_instance_of Transaction, @t
  end

  def test_item_has_id
    assert_equal 6, @t.id
  end

  def test_it_has_invoice_id
    assert_equal 8, @t.invoice_id
  end

  def test_credit_card_number_is_returned_able_to_change
    assert_equal "4242424242424242", @t.credit_card_number
  end

  def test_credit_card_expiration_date_is_returned_able_to_change
    assert_equal "0220", @t.credit_card_expiration_date
  end

  def test_result_returns_able_to_change
    assert_equal "success", @t.result
  end
end
