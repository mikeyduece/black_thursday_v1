require 'csv'

class Merchant

  attr_reader :name,
              :id,
              :merchant_repository

  def initialize(params, merchant_repository = nil)
    @name = params[:name]
    @id = params[:id]
    @merchant_repository = merchant_repository
  end

  def invoices
    merchant_repository.find_invoices(id)
    require "pry"; binding.pry
  end
end
