require 'csv'
require_relative '../lib/merchant'
class MerchantRepository

  attr_reader :all,
              :sales_engine

  def initialize(filename, sales_engine = nil)
    @sales_engine = sales_engine
    @all_items = []
    open_all_items(filename)
  end

  def open_all_items(filename)
    CSV.foreach filename, headers: true, header_converters: :symbol do |row|
      @all_items << Merchant.new(row,self)
    end
    @all_items
  end

  def all
    @all_items
  end

  def merchant_repository_invoices(merch_id)
    require "pry"; binding.pry
    @sales_engine.find_invoices(merch_id)

  end

  def find_by_id(id)
    all.find do |merchant|
      if merchant.id == id.to_s
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
    all_merchants = []
    all.find do |merchant|
      while merchant.name.downcase.include?(name.downcase)
        all_merchants << merchant
      return all_merchants
      end
      nil
    end
    return [] if all_merchants.empty?
    return all_merchants
  end
end
