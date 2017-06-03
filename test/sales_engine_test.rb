require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({:items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"})

    end
    se = SalesEngine.from_csv({:items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"})
  def test_its_a_thing

    items     = se.items
    merchants = se.merchants
    invoices  = se.invoices
    assert_instance_of ItemRepository, items
    assert_instance_of MerchantRepository, merchants
    assert_instance_of InvoiceRepository, invoices
  end

  def test_it_can_find_name
    items     = se.items
    assert_instance_of Item, items.find_by_name("Glitter scrabble frames")
  end

  def test_it_can_find_id
    items     = se.items
    assert_instance_of Item, items.find_by_id(263395617)
  end

  def test_it_can_find_price
    items     = se.items
    assert_instance_of Item, items.find_all_by_price(400.00)
  end

  def test_it_can_find_description
    items     = se.items
    assert_instance_of Array, items.find_all_with_description("More then 510+ icons")
  end

  def test_it_can_find_price_range
    items     = se.items
    assert_equal 62, items.find_all_by_price_in_range(1100..1300).length
  end

  def test_return_array_for_nil_range
    items     = se.items
    assert_equal [], items.find_all_by_price_in_range(0..0)
  end

  def test_it_find_merchant_id
    items     = se.items
    assert_instance_of Array, items.find_all_by_merchant_id(12334141)
  end

  def test_it_can_get_all_merchant
    merchants = se.merchants
    assert_instance_of Array, merchants.all
  end

  def test_it_can_get_merchants_names_through_merchant
    merchants = se.merchants
    assert_instance_of Merchant, merchants.find_by_name("Princessfrankknits")
  end

  def test_it_can_look_at_merchant_for_id
    merch = se.merchants
    assert_instance_of Merchant, merch.find_by_id(12334105)
  end

  def test_it_can_search_for_merchant_and_invoice_id
    merchant = se.merchants.find_by_id(12334145)
    invoice = se.invoices.find_by_id(20)
    assert_equal 14, merchant.invoices.length
    assert_instance_of Array, merchant.invoices
    assert_instance_of Merchant, invoice.merchant
  end

  def test_it_can_search_for_merchant_and_item_id
    merchant = se.merchants.find_by_id(12334112)
    assert_instance_of Array, merchant.items

  end
end
