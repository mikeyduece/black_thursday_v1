require 'csv'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative 'stats'

class SalesAnalyst
  attr_reader :se

  include Stats

  def initialize #do we need to add an argument?
    @se = SalesEngine.from_csv({ :items   => "./data/items.csv",
                                :merchants => "./data/merchants.csv",
                                :invoices => "./data/invoices.csv",
                                :invoice_items => "./data/invoice_items.csv",
                                :transactions => "./data/transactions.csv",
                                :customers => "./data/customers.csv"})
  end

  def average_items_per_merchant #REFACTOR FIRST
    total_items = @se.items.all
    total_merchants = @se.merchants.all
    average_items = total_items.count.to_f / total_merchants.count.to_f
    average_items.round(2)
  end

  def average_items_per_merchant_standard_deviation
    info = num_items_per_merchant
    standard_deviation(info).round(2)
  end

  def merchants_with_highest_item_count
    strong_offerers = []
    bar = average_items_per_merchant+average_items_per_merchant_standard_deviation
    merch_with_num_of_items_hash.each do |key, value|
      if value > bar
        strong_offerers << key
      else
      end
    end
    strong_offerers
  end

  def average_item_price_per_merchant(id)
    merchant_prices = []
      @se.items.find_all_by_merchant_id(id).each do |x|
        merchant_prices << x.unit_price
      end
   price_avg = (merchant_prices.reduce(:+)) / merchant_prices.length
   price_avg
  end

  def average_price_per_merchant
    prices_avgs = merch_id_array.map { |id| average_item_price_per_merchant(id)}
    avg_ppm = prices_avgs.reduce(:+) / prices_avgs.length
    avg_ppm
  end

  def golden_items
    prices_avgs = merch_id_array.map { |id| average_item_price_per_merchant(id)}
    price_bar = standard_deviation(prices_avgs) * 2
    golden_items = []
    @se.items.all.each do |item|
      if item.unit_price > price_bar
        golden_items << item
      else
      end
    end
    golden_items
  end

  def average_invoices_per_merchant
    info = @se.merchants.all.map {|merchant| merchant.invoices.count}
    average(info)
  end

  def average_invoices_per_merchant_standard_deviation
    info = @se.merchants.all.map {|merchant| merchant.invoices.count}
    standard_deviation(info)
  end

  def top_merchants_by_invoice_count
      info = @se.merchants.all.map {|merchant| merchant.invoices.count}
      cutoff = average(info) + (standard_deviation(info) * 2)
      @se.merchants.all.find_all {|merchant| merchant.invoices.length > cutoff}
  end

  def bottom_merchants_by_invoice_count
      info = @se.merchants.all.map {|merchant| merchant.invoices.count}
      cutoff = average(info) - (standard_deviation(info) * 2)
      @se.merchants.all.find_all {|merchant| merchant.invoices.length < cutoff}
  end

  def top_days_by_invoice_count
    #which DAYS OF THE WEEK are invoices created at more than 1 std deviation
    #above the mean
        #ret array of days of the week

      invoice_day.reduce({}) do |val, day|
            val[day] = 0 if val[day].nil?
            val[day] += 1
            val
        end
  end

  def invoice_status(status)
    #for :pending, :shipped, :returned
  end




#private-ish, could be a module? (put in stats_helper (stats))
  def num_items_per_merchant
    merch_ids = merch_id_array
      arr_n_items_by_merch =  []
      merch_ids.each do |id|
      arr_n_items_by_merch << @se.items.find_all_by_merchant_id(id).length
    end
    arr_n_items_by_merch
  end

  def merch_with_num_of_items_hash
    merch_name_array = []
    @se.merchants.all.each do |merch|
      merch_name_array << merch.name
    end
    nested_arr = merch_name_array.zip(num_items_per_merchant)
    hash = Hash[nested_arr]
  end

  def merch_id_array
    merch_id_array = []
    @se.merchants.all.each do |merch|
      merch_id_array << merch.id
    end
    merch_id_array
  end
end