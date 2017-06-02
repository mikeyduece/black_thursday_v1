require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'

class SalesEngine

  attr_reader :merchants, :items, :invoices

  def initialize(data)
    @items     = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
    @invoices  = InvoiceRepository.new(data[:invoices])
  end

  def self.from_csv(data)
    se = SalesEngine.new(data)
  end

  
end
