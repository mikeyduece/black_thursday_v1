require 'csv'

class Merchant

  attr_reader :name, :id

  def initialize(params, merchant_repository = nil)
    @name = params[:name]
    @id = params[:id]
    @merchant_repository = merchant_repository
  end

end
