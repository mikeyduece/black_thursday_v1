require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative '../lib/stats'
require 'csv'


class SalesAnalystTest < Minitest::Test
  include Stats

  def test_averages_items_per_merchant
    total_items = ItemRepository.new("./data/items.csv").all
    total_merchants = MerchantRepository.new("./data/merchants.csv").all
    instance = SalesAnalyst.new
    result = total_items.count.to_f / total_merchants.count.to_f
    assert_equal instance.average_items_per_merchant, result.round(2)
  end

  def test_average_items_per_mechant_standard_deviation
    instance = SalesAnalyst.new
    info = instance.num_items_per_merchant
    result = standard_deviation(info).round(2)
    assert_equal instance.average_items_per_merchant_standard_deviation, result
  end

  def test_produces_array_of_highest_item_count
    instance = SalesAnalyst.new
    strong_offerers = []
    bar = instance.average_items_per_merchant + instance.average_items_per_merchant_standard_deviation
    instance.merch_with_num_of_items_hash.each do |key, value|
      if value > bar
        strong_offerers << key
      else
      end
    end
    result = strong_offerers
    assert_equal instance.merchants_with_highest_item_count, result
  end

  def test_average_item_per_specific_merchant
    item_repository = ItemRepository.new("./data/items.csv")
    instance = SalesAnalyst.new
    merchant_prices = []
    item_repository.find_all_by_merchant_id(12334112).each do |x|
      merchant_prices << x.unit_price
    end
    price_avg = (merchant_prices.reduce(:+)) / merchant_prices.length
    result = price_avg
    assert_equal instance.average_item_price_per_merchant(12334112), result
  end

  def test_average_item_per_all_merchants
    instance = SalesAnalyst.new
    prices_avgs = instance.merch_id_array.map { |id| instance.average_item_price_per_merchant(id)}
    avg_ppm = prices_avgs.reduce(:+) / prices_avgs.length
    result = avg_ppm
    assert_equal instance.average_price_per_merchant, result
  end

  def test_returns_golden_items
    item_repository = ItemRepository.new("./data/items.csv")
    instance = SalesAnalyst.new
    prices_avgs = instance.merch_id_array.map { |id| instance.average_item_price_per_merchant(id)}
    price_bar = standard_deviation(prices_avgs) * 2
    gold_stuff = []
    item_repository.all.each do |item|
      if item.unit_price > price_bar
        gold_stuff << item
      else
      end
    end
    result = gold_stuff.count
    assert_equal instance.golden_items.count, result
  end
end


# require 'pry';binding.pry
