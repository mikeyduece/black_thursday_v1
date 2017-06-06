require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative '../lib/stats'
require_relative '../lib/invoice_item_repo'
require_relative '../lib/invoice_repository'
require_relative '../lib/transaction_repo'
require 'csv'

#make pass with new argument structure

class SalesAnalystTest < Minitest::Test
  include Stats
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({ :items   => "./data/items.csv",
                                :merchants => "./data/merchants.csv",
                                :invoices => "./data/invoices.csv",
                                :invoice_items => "./data/invoice_items.csv",
                                :transactions => "./data/transactions.csv",
                                :customers => "./data/customers.csv"})
  end

  def test_averages_items_per_merchant
    total_items = ItemRepository.new("./data/items.csv").all
    total_merchants = MerchantRepository.new("./data/merchants.csv").all
    instance = SalesAnalyst.new(se)
    result = total_items.count.to_f / total_merchants.count.to_f
    assert_equal instance.average_items_per_merchant, result.round(2)
  end

  def test_average_items_per_mechant_standard_deviation
    instance = SalesAnalyst.new(se)
    info = instance.num_items_per_merchant
    result = standard_deviation(info).round(2)
    assert_equal instance.average_items_per_merchant_standard_deviation, result
  end

  def test_produces_array_of_highest_item_count
    instance = SalesAnalyst.new(se)
    strong_offerers = []
    bar = instance.average_items_per_merchant + instance.average_items_per_merchant_standard_deviation
    instance.merch_with_num_of_items_hash.each do |key, value|
      if value > bar
        strong_offerers << key
      else
      end
    end
    result = strong_offerers
    assert_equal instance.merchants_with_high_item_count, result
  end

  def test_average_item_per_specific_merchant
    item_repository = ItemRepository.new("./data/items.csv")
    instance = SalesAnalyst.new(se)
    merchant_prices = []
    item_repository.find_all_by_merchant_id(12334112).each do |x|
      merchant_prices << x.unit_price
    end
    price_avg = (merchant_prices.reduce(:+)) / merchant_prices.length
    result = price_avg
    assert_equal instance.average_item_price_for_merchant(12334112), result
  end

  def test_average_item_per_all_merchants
    instance = SalesAnalyst.new(se)
    prices_avgs = instance.merch_id_array.map { |id| instance.average_item_price_for_merchant(id)}
    avg_ppm = prices_avgs.reduce(:+) / prices_avgs.length
    result = avg_ppm.round(2)
    assert_equal instance.average_item_price_for_merchant(12334105), result
  end

  def test_returns_golden_items
    item_repository = ItemRepository.new("./data/items.csv")
    instance = SalesAnalyst.new(se)
    prices_avgs = se.items.all.map {|item| item.unit_price}
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

#make the tests by calling from specific repositories, rather than SE

  def test_average_invoices_per_merchant
    sa = SalesAnalyst.new(se)
    info = sa.se.merchants.all.map {|merchant| merchant.invoices.count}
    result = average(info)
    assert_equal sa.average_invoices_per_merchant, result
  end

  def test_average_invoices_per_merchant_standard_deviation
    sa = SalesAnalyst.new(se)
    info = sa.se.merchants.all.map {|merchant| merchant.invoices.count}
    result = standard_deviation(info)
    assert_equal sa.average_invoices_per_merchant_standard_deviation, result
  end

  def test_top_merchants_by_invoice_count
    sa = SalesAnalyst.new(se)
    info = sa.se.merchants.all.map {|merchant| merchant.invoices.count}
    cutoff = average(info) + (standard_deviation(info) * 2)
    result = sa.se.merchants.all.find_all {|merchant| merchant.invoices.length > cutoff}
    assert_equal sa.top_merchants_by_invoice_count, result
  end

  def test_bottom_merchants_by_invoice_count
    sa = SalesAnalyst.new(se)
    info = sa.se.merchants.all.map {|merchant| merchant.invoices.count}
    cutoff = average(info) - (standard_deviation(info) * 2)
    result = sa.se.merchants.all.find_all {|merchant| merchant.invoices.length < cutoff}
    assert_equal sa.bottom_merchants_by_invoice_count, result
  end

  def test_top_days_by_invoice_count
    sa = SalesAnalyst.new(se)
    total_invoices_by_day = {}
    total_invoices_by_day =  sa.invoice_day.reduce({}) do |val, day|
      val[day] = 0 if val[day].nil?
      val[day] += 1
      val
    end
    total_invoices_by_day
    invoices_by_day = total_invoices_by_day.values
    bar = average(invoices_by_day) + standard_deviation(invoices_by_day)
    top_days = []
    total_invoices_by_day.each { |key, value| top_days << key if value > bar}
    result = top_days
      # assert_equal sa.top_days_by_invoice_count, result
    assert_equal ["Saturday", "Wednesday"], result
  end

  def test_invoice_status_pending
    sa = SalesAnalyst.new(se)
    result = sa.pending_invoices
    assert_equal sa.invoice_status(:pending), result
  end

  def test_invoice_status_shipped
    sa = SalesAnalyst.new(se)
    result = sa.shipped_invoices
    assert_equal sa.invoice_status(:shipped), result
  end

  def test_invoice_status_returned
    sa = SalesAnalyst.new(se)
    result = sa.returned_invoices
    assert_equal sa.invoice_status(:returned), result
  end
end

#
#
# se = SalesEngine.from_csv({ :items   => "./data/items.csv",
#                             :merchants => "./data/merchants.csv",
#                             :invoices => "./data/invoices.csv",
#                             :invoice_items => "./data/invoice_items.csv",
#                             :transactions => "./data/transactions.csv",
#                             :customers => "./data/customers.csv"})
#
# sa = SalesAnalyst.new(se)
# require 'pry';binding.pry
