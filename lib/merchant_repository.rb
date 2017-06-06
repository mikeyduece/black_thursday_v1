require 'csv'
require_relative 'merchant'
class MerchantRepository

  attr_reader :all,
              :sales_engine

  def initialize(filename, sales_engine = nil)
    @sales_engine = sales_engine
    @all_merchants = []
    open_all_items(filename)
  end

  def inspect
    "#<#{self.class} #{@all_merchants.size} rows>"
  end

  def open_all_items(filename)
    CSV.foreach filename, headers: true, header_converters: :symbol do |row|
      @all_merchants  << Merchant.new(row,self)
    end
    @all_merchants
  end

  def all
    @all_merchants
  end

  def merchant_repository_invoices(merch_id)
    sales_engine.find_invoices(merch_id)
  end

  def merchant_repository_items(id)
    sales_engine.find_items_by_merchant_id(id)
  end

  def find_merchants_customers(id)
    sales_engine.find_customers(id)
  end

  def find_by_id(id)
    all.find do |merchant|
      if merchant.id == id
        return merchant
      end
      nil
    end
  end

  def find_by_name(name)
    all.find do |merchant|
      if merchant.name.downcase == name.downcase
        return merchant
      end
      nil
    end
  end

  def find_all_by_name(name)
    all_merchants = all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
    return [] if all_merchants.empty?
    return all_merchants
  end
end
