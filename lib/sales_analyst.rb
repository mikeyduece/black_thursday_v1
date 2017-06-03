
# this could be a module?

require_relative 'sales_engine'


class SalesAnalyst
  attr_reader :se

  def initialze #this takes sales enigine as an argument
    @se =   se = SalesEngine.from_csv({:items     => "./data/items.csv",
                                 :merchants => "./data/merchants.csv",
                                 :invoices => "./data/invoices.csv"})
  end

  def average_items_per_mechant

  end

  def average_items_per_mechant_standard_deviation

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

end
