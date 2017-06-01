# require 'simplecov'
# SimpleCov.start
require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_its_a_thing
    se = SalesEngine.from_csv({:items     => "./data/items.csv",
                               :merchants => "./data/merchants.csv",})
    items     = se.items
    merchants = se.merchants
    assert_instance_of ItemsRepo, items
    assert_instance_of MerchantRepository, merchants
  end

  def test_it_can_find_name
    se = SalesEngine.from_csv({:items     => "./data/items.csv",
                               :merchants => "./data/merchants.csv",})
    items     = se.items
    assert_instance_of Items, items.find_by_name("Glitter scrabble frames")
  end

  def test_it_can_find_id
    se = SalesEngine.from_csv({:items     => "./data/items.csv",
                               :merchants => "./data/merchants.csv",})
    items     = se.items
    assert_instance_of Items, items.find_by_id(263395617)
  end

  def test_it_can_find_price
    se = SalesEngine.from_csv({:items     => "./data/items.csv",
                               :merchants => "./data/merchants.csv",})
    items     = se.items
    assert_instance_of Items, items.find_all_by_price(400.00)
  end

  def test_it_can_find_description
    se = SalesEngine.from_csv({:items     => "./data/items.csv",
                               :merchants => "./data/merchants.csv",})
    items     = se.items
  end
end
