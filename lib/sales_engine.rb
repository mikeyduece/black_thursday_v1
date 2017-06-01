require_relative '../lib/merchant_repository'
require_relative '../lib/items_repo'

class SalesEngine

  attr_reader :merchants, :items

  def initialize(data)
    @items     = ItemsRepo.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
  end

  def self.from_csv(data)
    se = SalesEngine.new(data)
  end
end
