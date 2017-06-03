require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require 'csv'


class SalesAnalystTest < Minitest::Test

  def test_it_exists
  se = SalesEngine.from_csv({:items     => "./data/items.csv",
                             :merchants => "./data/merchants.csv",
                             :invoices => "./data/invoices.csv"})
  result = SalesAnalyst.new
  result.se
  assert_instance_of SalesAnalyst, result
  end

end

require 'pry';binding.pry
