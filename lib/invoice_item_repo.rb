require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepo

  attr_reader :all, :sales_engine

  def initialize(filename, sales_engine = nil)
    @all_invoice_items = []
    @sales_engine = sales_engine
    open_all_items(filename)
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def open_all_items(filename)
    @all_invoice_items = []
    CSV.foreach filename, headers: true, header_converters: :symbol do |row|
      @all_invoice_items << InvoiceItem.new(row,self)
    end
    @all_invoice_items
  end

  def all
    @all_invoice_items
  end

  def find_item_by_id(id)
    sales_engine.find_item_by_id(id)
  end

  def find_by_id(id)
    all.find do |invoice_item|
      if invoice_item.id == id
        return invoice_item
      end
      nil
    end
  end

  def find_all_by_item_id(item_id)
    all_item_ids = []
    all.find_all do |invoice_item|
      if invoice_item.item_id == item_id
        all_item_ids << invoice_item
      end
    end
    return [] if all_item_ids.empty?
    return all_item_ids
  end

  def find_all_by_invoice_id(invoice_id)
    all_invoice_ids = []
    all.find_all do |invoice_item|
      if invoice_item.invoice_id == invoice_id
        all_invoice_ids << invoice_item
      end
    end
    return [] if all_invoice_ids.empty?
    return all_invoice_ids
  end
end
