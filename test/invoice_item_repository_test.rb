require_relative 'test_helper'
require_relative '../lib/invoice_item_repo'

class InvoiceItemRepoTest < Minitest::Test

  attr_reader :iir

  def setup
    @iir = InvoiceItemRepo.new("./data/test_invoice_items.csv")
  end

  def test_its_a_thing
    assert_instance_of InvoiceItemRepo, iir
  end

  def test_it_can_find_all_invoices
    assert_equal 99, iir.all.length
  end

  def test_it_can_find_by_id
    assert_instance_of InvoiceItem, iir.find_by_id(20)
  end

  def test_it_can_find_all_by_item_id
    assert_instance_of Array, iir.find_all_by_item_id(21)
    assert_equal 3, iir.find_all_by_item_id(21).length
  end

  def test_it_can_find_all_by_invoice_id
    assert_instance_of Array, iir.find_all_by_invoice_id(11)
    assert_equal 3, iir.find_all_by_invoice_id(11).length
  end

end
