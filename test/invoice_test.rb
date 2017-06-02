require './test/test_helper'
require './lib/invoice'

class InvoiceTest < Minitest::Test

  attr_reader :i

  def setup
      @i = Invoice.new({:id          => 6,
                        :customer_id => 7,
                        :merchant_id => 8,
                        :status      => "pending",
                        :created_at  => Time.now,
                        :updated_at  => Time.now,})
  end

  def test_it_can_find_id
    assert_equal 6, i.id
  end

  def test_it_can_find_customer_id
    assert_equal 7, i.customer_id
  end

  def test_it_can_find_merchant_id
    assert_equal 8, i.merchant_id
  end

  def test_can_tell_status
    assert_equal "pending", i.status
  end

  def test_it_can_tell_time
    assert_instance_of Time, i.created_at
    assert_instance_of Time, i.updated_at
  end

  def test_it_can_see_parent
    assert_equal 8, i.merchant
  end
end
