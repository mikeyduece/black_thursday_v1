class Transaction

  attr_reader :id, :invoice_id, :credit_card_number, :result,
              :credit_card_expiration_date, :created_at, :updated_at,
              :transaction_repo

  def initialize(params, transaction_repo = nil)
    @id                 = params[:id].to_i
    @invoice_id         = params[:invoice_id].to_i
    @credit_card_number = params[:credit_card_number].to_i
    @credit_card_expiration_date = params[:credit_card_expiration_date].to_s
    @created_at         = Time.parse(params[:created_at].to_s)
    @updated_at         = Time.parse(params[:updated_at].to_s)
    @result             = params[:result]
    @transaction_repo   = transaction_repo
  end

  def invoice
    transaction_repo.transaction_invoice(self.invoice_id)
  end


end
