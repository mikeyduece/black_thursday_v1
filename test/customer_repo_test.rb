require_relative 'test_helper'
require_relative '../lib/customer_repo'

class CustomerRepoTest < Minitest::Test
  attr_reader :cr

  def setup
    @cr = CustomerRepo.new("./data/test_customers.csv")
  end

  def test_it_exists
    assert_instance_of CustomerRepo, cr
  end

  def test_it_can_return_all_customers
    assert_instance_of Array, cr.all
    assert_equal 100, cr.all.length
  end

  def test_it_can_find_by_id
    assert_instance_of Customer, cr.find_by_id(20)
  end

  def test_returns_nil_with_wrong_id
    assert_nil cr.find_by_id(99999)
  end

  def test_can_it_find_all_first_name
    assert_instance_of Array, cr.find_all_by_first_name("Parker")
    assert_equal 1, cr.find_all_by_first_name("Parker").length
  end

  def test_it_can_find_last_names
    assert_instance_of Array, cr.find_all_by_last_name("Toy")
    assert_equal 1, cr.find_all_by_last_name("toy").length
  end

end
