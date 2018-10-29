require_relative './helper'
require_relative '../lib/customer'
class CustomerTest < Minitest::Test
  def setup
    @c = Customer.new( {:id => 6,
                        :first_name => "Joan",
                        :last_name => "Clarke",
                        :created_at => '2016-01-11 09:34:06 UTC',
                        :updated_at => '2007-06-04 21:35:10 UTC'
                        } )
  end

  def test_it_exists
    assert_instance_of Customer, @c
  end

  def test_it_returns_id
    assert_equal 6, @c.id
  end

  def test_it_returns_first_name_able_to_change
    assert_equal "Joan", @c.first_name
  end

  def test_it_returns_last_name_able_to_change
    assert_equal "Clarke", @c.last_name
  end
end
