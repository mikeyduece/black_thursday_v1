require 'csv'
require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'item'

class ItemRepository

  attr_reader :all, :sales_engine

  def initialize(filename, sales_engine=nil)
    @sales_engine = sales_engine
    @all_items = []
    open_all_items(filename)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def open_all_items(filename)
    CSV.foreach filename, headers: true, header_converters: :symbol do |row|
      @all_items << Item.new(row,self)
    end
    @all_items
  end

  def all
    @all_items
  end

  def item_repository_items(id)
    sales_engine.find_items(id)
  end

  def find_by_id(id)
    all.find do |item|
      if item.id == id
        return item
      end
      nil
    end
  end

  def find_by_name(name)
    all.find do |item|
      if item.name.downcase == name.downcase
        return item
      end
      nil
    end
  end

  def find_all_with_description(description)
    all_description = []
    all.find_all do |item|
      while item.description.downcase.include?(description.downcase)
        all_description << item
      return all_description
      end
      nil
    end
    return [] if all_description.empty?
    return all_description
  end

  def find_all_by_price(price)
    prices = all.find_all do |item|
      item.unit_price == price
    end
    return [] if prices.empty?
    return prices
  end

  def find_all_by_price_in_range(range)
    price_range = all.find_all do |item|
      range.include?(item.unit_price)
    end
    return [] if price_range.empty?
    return price_range
  end

  def find_all_by_merchant_id(merch_id)
    merchant_id_range = all.find_all do |item|
      item.merchant_id == merch_id
    end
    return [] if merchant_id_range.empty?
    return merchant_id_range
  end
end
