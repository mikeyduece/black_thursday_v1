require 'bigdecimal'
class Item

  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at,
              :merchant_id, :item_repository

  def initialize(params, item_repository = nil)
    @id = params[:id].to_i
    @name = params[:name]
    @description = params[:description]
    @unit_price = BigDecimal.new(params[:unit_price].insert(-3,"."))
    @merchant_id = params[:merchant_id].to_i
    @created_at = Time.parse(params[:created_at].to_s)
    @updated_at = Time.parse(params[:updated_at].to_s)
    @item_repository = item_repository
  end

  def unit_price_to_dollars
    unit_price / 100
  end

  def merchant
    item_repository.item_repository_items(self.merchant_id)
  end

end
