require 'time'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :invoice_repository

  def initialize(params, invoice_repository = nil)
    @id                 = params[:id].to_i
    @customer_id        = params[:customer_id].to_i
    @merchant_id        = params[:merchant_id].to_i
    @status             = params[:status].to_sym
    @created_at         = Time.parse(params[:created_at].to_s)
    @updated_at         = Time.parse(params[:updated_at].to_s)
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
      # require "pry"; binding.pry
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
