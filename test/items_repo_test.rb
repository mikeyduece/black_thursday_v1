gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/items_repo'

class ItemsRepoTest < Minitest::Test
  def test_its_a_thing
    ir = ItemsRepo.new("./data/items.csv")
    assert_instance_of ItemsRepo, ir
  end

  def test_it_can_find_by_id
    ir = ItemsRepo.new("./data/items.csv")

    assert_instance_of Items, ir.find_by_id(263395617)
  end

  def test_it_can_find_name
    ir = ItemsRepo.new("./data/items.csv")
    assert_instance_of Items, ir.find_by_name("Glitter scrabble frames")
  end

  def test_find_all_by_price
    ir = ItemsRepo.new("./data/items.csv")
    assert_instance_of Items, ir.find_all_by_unit_price(250)
  end

  def test_can_it_find_range_of_prices
    ir = ItemsRepo.new("./data/items.csv")
    assert_instance_of Items, ir.find_all_by_price_in_range(4)
  end

end
