
gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
  attr_reader :i

  def setup
    @i = Item.new({
      :id          => "5",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "2500",
      :created_at  => "2016-11-01 11:38:28 -0600",
      :updated_at  => "2016-11-01 14:38:28 -0600",
      :merchant_id => "10"})
  end
  def test_its_a_thing
    assert_instance_of Item, i
  end

  def test_it_see_by_id
    assert_equal 5, i.id
  end

  def test_it_can_find_name
    assert_equal  "Pencil", i.name
  end

  def test_it_can_find_description
    assert_equal  "You can use it to write things", i.description
  end

  def test_it_can_find_unit_price
    assert_instance_of BigDecimal, i.unit_price
  end

  def test_it_can_see_merchant_id
    assert_equal 10, i.merchant_id

  end

  def test_can_it_tell_time
    expected = Time.parse("2016-11-01 11:38:28 -0600")
    assert_equal expected, i.created_at
    assert_instance_of Time, i.created_at
  end

  def test_it_can_tell_updated_time
    expected_1 = Time.parse("2016-11-01 14:38:28 -0600")
    assert_equal expected_1, i.updated_at

  end
end
