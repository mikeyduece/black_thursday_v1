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

  def find_invoices(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
    require "pry"; binding.pry
  end

  def find_invoice_by_id(invoice_id)
    invoices.find_by_id(invoice_id)
  end

  def find_merchant_by_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end
end
