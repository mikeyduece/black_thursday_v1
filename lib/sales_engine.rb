require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'

class SalesEngine

  attr_reader :merchants, :items, :invoices

  def initialize(data)
    @items     = ItemRepository.new(data[:items],self)
    @merchants = MerchantRepository.new(data[:merchants],self)
    @invoices  = InvoiceRepository.new(data[:invoices],self)
  end

  def self.from_csv(data)
    se = SalesEngine.new(data)
  end

  def find_invoices(merch_id)
    invoices.find_all_by_merchant_id(merch_id)
  end

  def find_merchants_by_invoice_id(id)
    merchants.find_by_id(id)
  end

  def find_items_by_merchant_id(id)
    items.find_by_id(id)
  end

  def find_items(id)
    merchants.find_by_id(id)
  end

  def all_merchants
    merchants.all
  end

  def all_invoices
    invoice.all
  end

end
