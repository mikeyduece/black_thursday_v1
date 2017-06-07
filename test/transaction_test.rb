require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test

  attr_reader :trans

  def setup
    @trans = Transaction.new({:id => 6,
                              :invoice_id => 8,
                              :credit_card_number => "4242424242424242",
                              :credit_card_expiration_date => "0220",
                              :result => "success",
                              :created_at => Time.now,
                              :updated_at => Time.now})
  end
  def trest_its_a_thing
    assert_instance_of Transaction, trans
  end

  def test_it_can_see_id
    assert_equal 6, trans.id
  end

  def test_it_can_see_invoice_id
    assert_equal 8, trans.invoice_id
  end

  def test_it_can_read_cc_num
    assert_equal 4242424242424242, trans.credit_card_number
  end

  def test_it_can_tell_exp_date
    assert_equal "0220", trans.credit_card_expiration_date
  end

  def test_it_can_tell_time
    assert_instance_of Time, trans.created_at
    assert_instance_of Time, trans.updated_at
  end

end
