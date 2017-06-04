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
    invoice_repository.invoice_repository_merchant(self.merchant_id)
  end

  def items
    invoice_repository.invoice_repository_items(self.merchant_id)
  end

  def transactions
    invoice_repository.invoice_transactions(self.id)
  end

  def customer
    invoice_repository.customer_invoices(self.customer_id)
  end

  def invoice_items
    invoice_repository.get_invoice_items_for_invoice(id)
  end

  def total
    total = invoice_items.map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end.reduce(:+)
    return total.round(2) if total && self.is_paid_in_full?
  end

  def transaction_result
    invoice_repository.find_transaction_result(id)
  end

  def is_paid_in_full?
    transaction_result.any? {|transaction| transaction.result == "success"}
  end
end
