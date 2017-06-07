require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  attr_reader :ii
  def setup
    @ii = InvoiceItem.new({:id => 6,
                          :item_id => 7,
                          :invoice_id => 8,
                          :quantity => 1,
                          :unit_price => BigDecimal.new(10.99, 4).to_s,
                          :created_at => Time.now,
                          :updated_at => Time.now})
  end

  def test_its_a_thing
    assert_instance_of InvoiceItem, ii
  end

  def test_it_can_find_id
    assert_equal 6, ii.id
  end

  def test_it_can_find_item_id
    assert_equal 7, ii.item_id
  end

  def test_it_can_find_invoice_id
    assert_equal 8, ii.invoice_id
  end

  def test_it_can_count
    assert_equal 1, ii.quantity
  end

  def test_it_can_grab_unit_price
    assert_instance_of BigDecimal, ii.unit_price
  end

  def test_it_can_tell_time
    assert_instance_of Time, ii.updated_at
    assert_instance_of Time, ii.created_at
  end
end
