require 'bigdecimal'
class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at,
              :updated_at

  def initialize(params, invoice_item_repo=nil)
    @id = params[:id]
    @item_id = params[:item_id]
    @invoice_id = params[:invoice_id]
    @quantity = params[:quantity]
    @unit_price = params[:unit_price]
    @created_at = params[:created_at]
    @updated_at = params[:updated_at]
  end

end
