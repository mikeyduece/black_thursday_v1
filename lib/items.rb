require 'bigdecimal'
class Items

  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at
              :merchant_id

  def initialize(params, parent = nil)
    @id = params[:id]
    @name = params[:name]
    @description = params[:description]
    @unit_price = params[:unit_price]#.to_d
    @merchant_id = params[:merchant_id]
    @created_at = params[:created_at]
    @updated_at = params[:updated_at]
  end

  def unit_price_to_dollars
    dollars = unit_price.to_f
  end

end
