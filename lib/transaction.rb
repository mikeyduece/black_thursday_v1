class Transaction

  attr_reader :id, :invoice_id, :cc_num, :result,
              :cc_exp, :created_at, :updated_at

  def initialize(params, trans_repo = nil)
    @id         = params[:id]
    @invoice_id = params[:invoice_id]
    @cc_num     = params[:credit_card_number]
    @cc_exp     = params[:credit_card_expiration_date]
    @created_at = params[:created_at]
    @updated_at = params[:updated_at]
    @result     = params[:result]
  end


end
