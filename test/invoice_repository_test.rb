require './test/test_helper'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :ir

  def setup
    @ir = InvoiceRepository.new("./data/invoices.csv")
  end

  def test_its_a_thing
    assert_instance_of InvoiceRepository, ir
  end

  def test_it_can_find_all_invoices
    assert_equal 4985, ir.all.length
  end

  def test_it_can_find_by_id
    assert_instance_of Invoice, ir.find_by_id(100)
  end

  def test_it_can_find_all_customers_by_id
    assert_instance_of Array, ir.find_all_by_customer_id(20)
  end

  def test_find_all_statuses
    assert_instance_of Array, ir.find_all_by_status("pending")
    assert_instance_of Array, ir.find_all_by_status("shipped")
  end

  def test_it_can_find_all_by_merchant_id
    assert_instance_of Array, ir.find_all_by_merchant_id(12337139)
  end

end
