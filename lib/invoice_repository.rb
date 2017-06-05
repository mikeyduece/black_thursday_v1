require 'csv'
require_relative 'invoice'

class InvoiceRepository

  attr_reader :all, :sales_engine

  def initialize(filename, sales_engine = nil)
    @all =open_all_items(filename)
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def open_all_items(filename)
    all_items = []
    CSV.foreach filename, headers: true, header_converters: :symbol do |row|
      all_items << Invoice.new(row,self)
    end
    all_items
  end

  def get_invoice_items_for_invoice(invoice_id)
    sales_engine.find_invoice_items_for_invoice(invoice_id)
  end

  def invoice_repository_merchant(id)
    @sales_engine.find_merchants_by_invoice_id(id)
  end

  def invoice_repository_items(id)
    @sales_engine.find_items_by_invoice(id)
  end

  def invoice_transactions(invoice_id)
    sales_engine.find_transactions_by_invoice_id(invoice_id)
  end

  def customer_invoices(customer_id)
    sales_engine.find_customer_invoice(customer_id)
  end

  def find_transaction_result(invoice_id)
    sales_engine.find_transactions_by_invoice_id(invoice_id)
  end


  def find_by_id(id)
    all.find do |invoice|
      if invoice.id == id
        # require "pry"; binding.pry
        return invoice
      end
      nil
    end
  end

  def find_all_by_customer_id(customer_id)
    all_customers = all.find_all do |invoice|
      invoice.customer_id == customer_id
    end
    return [] if all_customers.empty?
    return all_customers
  end

  def find_all_by_status(status_input)
    #returns [] or matches to status
    all_statuses = []
    all.find_all do |invoice|
      if invoice.status == status_input
        all_statuses << invoice
      end
    end
    return [] if all_statuses.empty?
    return all_statuses
  end

  def find_all_by_merchant_id(merch_id)
    #returns [] ro matches to merchant_id
    all_merchant_ids = []
    all.find_all do |invoice|
      if invoice.merchant_id == merch_id.to_s
        all_merchant_ids << invoice
      end
    end
    return [] if all_merchant_ids.empty?
    return all_merchant_ids
  end

end
