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
end
