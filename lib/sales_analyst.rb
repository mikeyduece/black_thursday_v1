
#make a module
#include Mike's Stats module ?

require 'csv'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative 'stats'

class SalesAnalyst
  attr_reader :se,
              :items_repository,
              :merchant_repository

  include Stats

  def initialize #this takes sales enigine as an argument
    @se =   se = SalesEngine.from_csv({:items     => "./data/items.csv",
                                 :merchants => "./data/merchants.csv",
                                 :invoices => "./data/invoices.csv"})
    @items_repository = ItemRepository.new("./data/items.csv")
    @merchant_repository = MerchantRepository.new("./data/merchants.csv")
  end

  def items_repository
    @items_repository
  end

  def merchant_repository
    @merchant_repository
  end



  def average_items_per_merchant #refactor
    total_items = ItemRepository.new("./data/items.csv").all
    total_merchants = MerchantRepository.new("./data/merchants.csv").all
    average_items = total_items.count.to_f / total_merchants.count.to_f
    average_items.round(2)
  end

  def average_items_per_merchant_standard_deviation
    info = num_items_per_merchant
    standard_deviation(info).round(2)
  end

  def merchants_with_highest_item_count
    #returns which merchants are more than one standard deviation above
    #the average number of products offered, returned in an array
  end

  def average_item_price_per_merchant(id)

    #returns bigdecimal
  end

  def average_price_per_merchant

    # returns sums all merchants price averages and averages them
    #returns BigDecimal

  end

  def golden_items
    #returns array of item objects two (at least?) two standard deviations above
    #the average item price.
  end




  def num_items_per_merchant
    merch_id_array = []
    @merchant_repository.all.each do |merch|
      merch_id_array << merch.id
    end
      arr_n_items_by_merch =  []
      merch_id_array.each do |id|
      arr_n_items_by_merch << @items_repository.find_all_by_merchant_id(id).length
    end
    arr_n_items_by_merch
  end

end

#
# instance = SalesAnalyst.new
# require'pry'; binding.pry
