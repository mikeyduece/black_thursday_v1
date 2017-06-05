gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_its_a_thing
    mr = MerchantRepository.new("./data/merchants.csv")
    assert_instance_of MerchantRepository, mr
  end

  def test_it_can_return_all_merchants
    mr = MerchantRepository.new("./data/merchants.csv")
    # expected = "12334234,Princessfrankknits,2002-09-22,2010-01-25"
    assert_equal 475, mr.all.length
  end

  def test_it_can_find_by_id
    mr = MerchantRepository.new("./data/merchants.csv")

    assert_instance_of Merchant, mr.find_by_id(12334105)
  end

  def test_it_returns_nil_for_wrong_id
    mr = MerchantRepository.new("./data/merchants.csv")
    assert_nil mr.find_by_id(99999999999)
  end

  def test_it_can_find_name
    mr = MerchantRepository.new("./data/merchants.csv")
    assert_instance_of Merchant, mr.find_by_name("Princessfrankknits")
  end

  def test_it_returns_nil_if_wrong_name
    mr = MerchantRepository.new("./data/merchants.csv")
    assert_nil mr.find_by_name("Princessfrank")
  end

  def def_test_it_can_find_all_names_by_frag
    mr = MerchantRepository.new("./data/test_merchants.csv")
    assert_instance_of Array, mr.find_all_by_name("style")

    assert_equal 3, mr.find_all_by_name("style").count
  end



end
