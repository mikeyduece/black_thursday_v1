require 'bigdecimal'
class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at,
              :updated_at, :invoice_item_repo

  def initialize(params, invoice_item_repo=nil)
    @id = params[:id].to_i
    @item_id = params[:item_id].to_i
    @invoice_id = params[:invoice_id].to_i
    @unit_price = BigDecimal.new(params[:unit_price].insert(-3,"."))
    @quantity = params[:quantity].to_i
    @created_at = Time.parse(params[:created_at].to_s)
    @updated_at = Time.parse(params[:updated_at].to_s)
    @invoice_item_repo = invoice_item_repo
  end

  def item
    @invoice_item_repo.find_item_by_id(self.item_id)
  end
end
