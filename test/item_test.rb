require_relative './helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def setup
    @time_now = Time.now
    @i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @time_now,
      :updated_at  => Time.now,
      :merchant_id => 2
      })
  end

  def test_item_exists
    assert_instance_of Item, @i
  end

  def test_item_has_id
    assert_equal 1, @i.id
  end

  def test_item_has_name
    assert_equal "Pencil", @i.name
  end

  def test_it_has_description
    assert_equal "You can use it to write things", @i.description
  end

  def test_it_has_a_unit_price
    assert_equal BigDecimal.new(10.99,4), @i.unit_price
  end

  def test_it_can_be_created_at_a_certain_time

    assert_equal @time_now, @i.created_at
  end


end
