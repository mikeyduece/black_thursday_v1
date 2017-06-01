require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngine

  attr_reader :merchants, :items

  def initialize(data)
    @items     = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
  end

  def self.from_csv(data)
    se = SalesEngine.new(data)
  end
end
