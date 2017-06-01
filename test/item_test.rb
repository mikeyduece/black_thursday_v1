gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
  def test_its_a_thing
    i = Item.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now,})

    assert_instance_of Item, i
  end

  def test_it_find_by_id
    skip
    i = Item.new({:name        => "Pencil",
                  :id          => 1,
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now,})
    assert_equal 1, i.id
  end

  def test_it_can_find_name
    skip
    i = Item.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now,})
    assert_equal  "Pencil", i.name
  end

  def test_it_can_find_description
    skip
    i = Item.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now,})
    assert_equal  "You can use it to write things", i.description
  end

  def test_it_can_find_unit_price
    skip
    i = Item.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now,})
    assert_instance_of BigDecimal, i.unit_price
  end

  def test_it_can_see_merchant_id
    i = Item.new({:name        => "Pencil",
                  :id => 1,
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :merchant_id => 321,
                  :created_at  => Time.now,
                  :updated_at  => Time.now,})
                  require "pry"; binding.pry
    assert_equal 321, i.merchant_id

  end

  def test_can_it_tell_time
    skip
    i = Item.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now,})

    assert_instance_of Time, i.created_at
    assert_instance_of Time, i.updated_at
  end
end
