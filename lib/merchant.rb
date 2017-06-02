require 'csv'

class Merchant

  attr_reader :name,
              :id,
              :merchant_repository

  def initialize(params, merchant_repository = nil)
    @name = params[:name]
    @id = params[:id]
    @merchant_repository = merchant_repository
    require "pry"; binding.pry
  end

  def merchants
    merchant_repository.find_by_id(id)
  end


end
