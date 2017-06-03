require 'bigdecimal'
class Item

  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at,
              :merchant_id

  def initialize(params, item_repository = nil)
    @id = params[:id]
    @name = params[:name]
    @description = params[:description]
    @unit_price = BigDecimal.new(params[:unit_price],4)
    @merchant_id = params[:merchant_id]
    @created_at = params[:created_at]
    @updated_at = params[:updated_at]
    @item_repository = item_repository
  end

  def unit_price_to_dollars
    unit_price / 100
  end

  def merchants
    item_repository.item_repository_items(id)
  end

end
