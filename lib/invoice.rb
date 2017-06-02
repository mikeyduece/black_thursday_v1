class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :invoice_repository

  def initialize(params, invoice_repository = nil)
    @id                 = params[:id]
    @customer_id        = params[:customer_id]
    @merchant_id        = params[:merchant_id]
    @status             = params[:status]
    @created_at         = params[:created_at]
    @updated_at         = params[:updated_at]
    @invoice_repository = invoice_repository
  end

  def merchant
    invoice_repository.invoice_repository_merchant(id)
  end
end
