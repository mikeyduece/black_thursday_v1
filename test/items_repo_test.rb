gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repo'

class ItemRepoTest < Minitest::Test
  def test_its_a_thing
    ir = ItemRepo.new("./data/items.csv")
    assert_instance_of ItemRepo, ir
  end

  def test_it_can_find_by_id
    ir = ItemRepo.new("./data/items.csv")

    assert_instance_of Item, ir.find_by_id(263395617)
  end

  def test_it_can_find_name
    ir = ItemRepo.new("./data/items.csv")
    assert_instance_of Item, ir.find_by_name("Glitter scrabble frames")
  end

  def test_find_all_by_price
    ir = ItemRepo.new("./data/items.csv")
    assert_instance_of Item, ir.find_all_by_unit_price(250)
  end

  def test_return_empty_array_for_bum_price
    ir = ItemRepo.new("./data/items.csv")
    assert_equal [], ir.find_all_by_unit_price(9999999999999999999999)
  end

  def test_can_it_find_range_of_prices
    ir = ItemRepo.new("./data/items.csv")
    assert_equal 317, ir.find_all_by_price_in_range(10..20).length
  end

  def test_it_will_return_empty_arary_with_bum_range
    ir = ItemRepo.new("./data/items.csv")
    assert_equal [], ir.find_all_by_price_in_range(0..0)
  end

  def test_it_can_find_range_of_merchant_id
    ir = ItemRepo.new("./data/items.csv")
    assert_equal 
  end

end
