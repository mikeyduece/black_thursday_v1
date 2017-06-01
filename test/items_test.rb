gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/items'

class ItemsTest < Minitest::Test
  def test_its_a_thing
    i = Items.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now,})
    assert_instance_of Items, i
  end

  def test_it_can_find_name
    i = Items.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now,})
    assert_equal  "Pencil", i.name
  end

  def test_it_can_find_description
    i = Items.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now,})
    assert_equal  "You can use it to write things", i.description
  end

  def test_it_can_find_unit_price
    i = Items.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now,})
    assert_instance_of BigDecimal, i.unit_price
  end

  def test_can_it_tell_time
    i = Items.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now,})

    assert_instance_of Time, i.created_at
    assert_instance_of Time, i.updated_at
  end
end
