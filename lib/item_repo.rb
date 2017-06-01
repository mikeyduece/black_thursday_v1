require 'csv'
require 'bigdecimal'
require 'bigdecimal/util'
require_relative '../lib/item'

class ItemRepo

  attr_reader :all

  def initialize(file)
    handle = CSV.open file, headers: true, header_converters: :symbol
    @all = handle.map {|row| Item.new(row,self)}
    require "pry"; binding.pry
  end

  def find_by_id(id)
    all.find do |item|
      if item.id == id.to_s
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
    all.find do |item|
      while item.description.downcase.include?(description.downcase)
        all_description << item
      return all_description
      end
      nil
    end
    return [] if all_description.empty?
    return all_description
  end

  def find_all_by_unit_price(price)
    prices = []
    all.find do |item|
      while item.unit_price == price.to_f
        prices << item
        return item
      end
      nil
    end
    return [] if prices.empty?
    return prices

  end

  def find_all_by_price_in_range(range)
    price_range = all.find_all do |item|
      range.include?(item.unit_price)
      # require "pry"; binding.pry
    end
    return [] if price_range.nil?
    return price_range
  end

  def find_all_by_merchant_id

  end
end
