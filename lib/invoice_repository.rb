require 'csv'
require_relative '../lib/invoice'

class InvoiceRepository

  attr_reader :all,
              :sales_engine

  def initialize(filename, sales_engine = nil)
    @all =open_all_items(filename)
    @sales_engine = sales_engine
  end

  def open_all_items(filename)
    all_items = []
    CSV.foreach filename, headers: true, header_converters: :symbol do |row|
      all_items << Invoice.new(row,self)
    end
    all_items
  end

  def find_merchant_by_id(merchant_id)
    sales_engine.find_merchant_by_id(merchant_id)
    require "pry"; binding.pry
  end

  def find_by_id(id)
    #returns nil or instance of invoice
    all.find do |invoice|
      if invoice.id == id.to_s
        return invoice
      end
    end
  end

  def find_all_by_customer_id(customer_id)
    #returns [] or matches to customer_id
    all_customers = []
    all.find_all do |invoice|
      if invoice.customer_id == customer_id.to_s
        all_customers << invoice
      end
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
