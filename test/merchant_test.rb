gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_its_a_thing
    merchant = Merchant.new({:id => 12334234,
                       :name => "Princessfrankknits"})
    assert_instance_of Merchant, merchant
  end

  def test_it_can_find_name
    mr = Merchant.new({:id => 12334234,
                       :name => "Princessfrankknits"})
    assert_equal "Princessfrankknits", mr.name
  end

  def test_it_can_find_id
    mr = Merchant.new({:id => 12334234,
                       :name => "Princessfrankknits"})
    assert_equal 12334234, mr.id
  end

end
