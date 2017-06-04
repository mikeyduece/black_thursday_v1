require 'csv'

class Merchant

  attr_reader :name,
              :id,
              :merchant_repository

  def initialize(params, merchant_repository=nil)
    @name = params[:name]
    @id = params[:id]
    @merchant_repository = merchant_repository
  end

  def invoices
    merchant_repository.merchant_repository_invoices(id)
  end

  def items
    merchant_repository.merchant_repository_items(id)
  end

  def customers
    merchant_repository.find_merchants_customers(id)
  end
end 
