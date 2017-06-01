require './test/test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_its_a_thing
    ir = ItemRepository.new("./data/items.csv")
    assert_instance_of ItemRepository, ir
  end

  def test_it_can_return_all_items
    ir = ItemRepository.new("./data/items.csv")
    assert_equal 1367, ir.all.count
  end

  def test_it_can_find_by_id
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of Item, ir.find_by_id(263395617)
  end

  def test_it_can_find_name
    ir = ItemRepository.new("./data/items.csv")
    assert_instance_of Item, ir.find_by_name("Glitter scrabble frames")
  end

  def test_it_can_find_by_description
    i = Item.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now,
                })
    ir = ItemRepository.new("./data/items.csv")
    ir.all << i
    assert_equal [i], ir.find_all_with_description("You can use it to write things")
    assert_instance_of Array, ir.find_all_with_description("More then 510+ icons")
  end

  def test_find_all_by_price
    ir = ItemRepository.new("./data/items.csv")
    assert_instance_of Item, ir.find_all_by_price(250)
  end

  def test_return_empty_array_for_bum_price
    ir = ItemRepository.new("./data/items.csv")
    assert_equal [], ir.find_all_by_price(9999999999999999999999)
  end

  def test_can_it_find_range_of_prices
    ir = ItemRepository.new("./data/items.csv")
    assert_equal 62, ir.find_all_by_price_in_range(1100..1300).length
  end

  def test_it_will_return_empty_arary_with_bum_range
    ir = ItemRepository.new("./data/items.csv")
    assert_equal [], ir.find_all_by_price_in_range(0..0)
  end

  def test_it_can_find_range_of_merchant_id
    ir = ItemRepository.new("./data/items.csv")
    assert_instance_of Array, ir.find_all_by_merchant_id(12334141)
  end

end
