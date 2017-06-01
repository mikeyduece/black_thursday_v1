require 'csv'
require_relative '../lib/invoice'

class InvoiceRepository

  attr_reader :all

  def initialize(filename)
    @all =open_all_items(filename)
  end

  def open_all_items(filename)
    all_items = []
    CSV.foreach filename, headers: true, header_converters: :symbol do |row|
      all_items << Invoice.new(row,self)
    end
    all_items
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

  def find_all_by_status
    #returns [] or matches to status
    all_statuses = []
    
  end

  def find_all_by_merchant_id
    #returns [] ro matches to merchant_id
  end

end
