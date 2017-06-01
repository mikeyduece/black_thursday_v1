require 'csv'
require_relative '../lib/merchant'
class MerchantRepository

  attr_reader :all

  def initialize(file)
    handle = CSV.open file, headers: true, header_converters: :symbol
    @all = handle.map {|row| Merchant.new(row,self)}
    # require "pry"; binding.pry
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
