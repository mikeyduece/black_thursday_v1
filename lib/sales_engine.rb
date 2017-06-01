require 'csv'
# require_relative '../lib/merchant'

class SalesEngine

  attr_reader :merchants, :items

  def self.from_csv(data)
    items = CSV.open "./data/merchants.csv",headers: true, header_converters: :symbol
    merchants = CSV.open "./data/items.csv",headers: true, header_converters: :symbol
  end
end
