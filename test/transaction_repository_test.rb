require_relative './helper'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'
class TransactionRepositoryTest < Minitest::Test
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
    assert_instance_of TransactionRepository, @se.transactions
  end

  def test_it_can_get_all_transactions
    assert_equal 4985, @se.transactions.all.count
  end

  def test_it_can_find_by_id
    assert_instance_of Transaction, @se.transactions.find_by_id(10)
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal 2, @se.transactions.find_all_by_invoice_id(2179).count
  end

  def test_it_can_find_all_by_cc_number
    assert_equal 1, @se.transactions.find_all_by_credit_card_number('4068631943231473').count
  end

  def test_it_can_find_all_by_result
    assert_equal 827, @se.transactions.find_all_by_result(:failed).count
  end

  def test_it_can_create_a_new_transaction
    attributes = {
                invoice_id: 4,
                credit_card_number: '4747474747474747',
                credit_card_expiration_date: '0320',
                result: 'success'
                  }
    assert_instance_of Transaction, @se.transactions.create(attributes)
  end

  def test_it_can_update_a_transaction
    @se.transactions.update(1, {
                               credit_card_number: '5757575757575757',
                               credit_card_expiration_date: '0121',
                               result: 'failed'
                               } )
    assert_equal 5757575757575757, @se.transactions.find_by_id(1).credit_card_number
    assert_equal '0121', @se.transactions.find_by_id(1).credit_card_expiration_date
    assert_equal :failed, @se.transactions.find_by_id(1).result
  end

  def test_it_can_delete_a_transaction
    @se.transactions.delete(1)
    assert_equal 4984, @se.transactions.all.count
  end
end
