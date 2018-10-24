require_relative './helper'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new('./data/merchants.csv')
    assert_instance_of MerchantRepository, mr
  end

  def test_it_can_create_merchants
    mr = MerchantRepository.new('./data/merchants.csv')
    assert_equal 475, mr.merchants.count
  end

  def test_can_return_array_of_all_merchant_instances
    mr = MerchantRepository.new('./data/merchants.csv')
    mr.merchants
    assert_equal 475, mr.all.count
  end
end
