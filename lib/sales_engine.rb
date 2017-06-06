require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repo'
require_relative 'transaction_repo'
require_relative 'customer_repo'

class SalesEngine

  attr_reader :merchants, :items, :invoices,
              :transactions, :customers, :invoice_items

  def initialize(data)
    @items         = ItemRepository.new(data[:items],self)
    @merchants     = MerchantRepository.new(data[:merchants],self)
    @invoices      = InvoiceRepository.new(data[:invoices],self)
    @invoice_items = InvoiceItemRepo.new(data[:invoice_items],self)
    @transactions  = TransactionRepo.new(data[:transactions],self)
    @customers     = CustomerRepo.new(data[:customers],self)
  end

  def self.from_csv(data)
    se = SalesEngine.new(data)
  end

  def find_invoice_items_for_invoice(invoice_id)
    invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def find_customers(merchant_id)
    customer_array = invoices.find_all_by_merchant_id(merchant_id)
    customer_array.map {|invoice| invoice.customer}.uniq
  end

  def find_merchants_of_customers(customer_id)
    merchant_array = invoices.find_all_by_customer_id(customer_id)
    merchant_array.map {|invoice| invoice.merchant}
  end

  def find_transaction_invoice_by_id(id)
    invoices.find_by_id(id)
  end

  def find_items_by_invoice(id)
    items_arr = invoice_items.find_all_by_invoice_id(id)
    items_arr.map {|invoice_item| invoice_item.item}
    # require "pry"; binding.pry
  end

  def find_invoices(merch_id)
    invoices.find_all_by_merchant_id(merch_id)
  end

  def find_merchants_by_invoice_id(id)
    merchants.find_by_id(id)
  end

  def find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_customer_invoice(customer_id)
    customers.find_by_id(customer_id)
  end

  def find_item_by_id(id)
    items.find_by_id(id)
  end

  def find_items(id)
    merchants.find_by_id(id)
  end

  def all_merchants
    merchants.all
  end

  def all_invoices
    invoices.all
  end

end
