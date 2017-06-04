require_relative 'test_helper'
require_relative '../lib/transaction_repo'

class TransactionRepoTest < Minitest::Test
  attr_reader :tr

  def setup
    @tr = TransactionRepo.new("./data/test_transaction.csv")
  end

  def test_its_a_thing
    assert_instance_of TransactionRepo, tr
  end

  def test_it_can_see_all
    assert_equal 99, tr.all.length
  end

  def test_it_can_find_by_id
    assert_instance_of Transaction, tr.find_by_id(22)
  end

  def test_it_can_find_all_by_invoice_id
    assert_instance_of Array, tr.find_all_by_invoice_id(46)
    assert_equal 1, tr.find_all_by_invoice_id(46).length
  end

  def test_it_can_find_all_by_cc_num
    assert_instance_of Array, tr.find_all_by_cc_num(4068631943231473)
    assert_equal 1, tr.find_all_by_cc_num(4068631943231473).length
  end

  def test_it_can_find_all_results
    assert_instance_of Array, tr.find_all_by_result("success")
    assert_instance_of Array, tr.find_all_by_result("failed")
  end

end
