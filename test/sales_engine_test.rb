require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({:items         => "./data/items.csv",
                                :merchants     => "./data/merchants.csv",
                                :invoices      => "./data/test_invoices.csv",
                                :invoice_items => "./data/test_invoice_items.csv",
                                :transactions  => "./data/test_transactions.csv",
                                :customers     => "./data/test_customers.csv"})

  end

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
    assert_instance_of Array, merchant.invoices
    assert_instance_of Merchant, invoice.merchant
  end

  def test_it_can_search_for_merchant_and_item_id
    merchant = se.merchants.find_by_id(12334112)
    item = se.items.find_by_id(263395237)
    assert_instance_of Array, merchant.items
    assert_instance_of Merchant, item.merchant
  end

  def test_invoice_can_talk_to_items
    invoice = se.invoices.find_by_id(11)
    assert_instance_of Array, invoice.items
    assert_instance_of Item, invoice.items[0]
    #need to check if filled with item obj
  end
  def test_invoice_can_talk_to_transactions
    invoice = se.invoices.find_by_id(46)
    assert_instance_of Array, invoice.transactions
    assert_equal 1, invoice.transactions.length
    assert_instance_of Transaction, invoice.transactions[0]
  end
  def test_invoice_can_talk_to_customer
    invoice = se.invoices.find_by_id(21)
    assert_instance_of Customer, invoice.customer
  end

  def test_can_transaction_talk_to_invoice
    transaction = se.transactions.find_by_id(40)
    assert_instance_of Invoice, transaction.invoice
  end

  def test_merchants_can_talk_to_customers
    merchant = se.merchants.find_by_id(12335938)
    assert_instance_of Array, merchant.customers
    assert_instance_of Customer, merchant.customers[0]
  end

  def test_customer_can_talk_to_merchant
    customer = se.customers.find_by_id(21)
    assert_instance_of Array, customer.merchants
    assert_instance_of Merchant, customer.merchants[0]
  end

  def test_invoice_can_talke_to_invoice_item
    invoice = se.invoices.find_by_id(14)
    assert_instance_of Array, invoice.invoice_items
    assert_instance_of InvoiceItem, invoice.invoice_items[0]
  end

  def test_it_can_see_if_fully_paid
    invoice = se.invoices.find_by_id(46)
    assert invoice.is_paid_in_full?
  end

  def test_it_can_see_who_has_not_paid
    invoice = se.invoices.find_by_id(1752)
    refute invoice.is_paid_in_full?
  end

  def test_it_can_count_totals
    invoice = se.invoices.find_by_id(14)

    assert_instance_of BigDecimal, invoice.total
    assert_equal BigDecimal.new('0.22767E5'), invoice.total 
  end
end
