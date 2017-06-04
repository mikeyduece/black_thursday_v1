class Customer

  attr_reader :id, :first_name, :last_name, :created_at, :updated_at,
              :customer_repo

  def initialize(params, customer_repo=nil)
    @id            = params[:id]
    @first_name    = params[:first_name]
    @last_name     = params[:last_name]
    @created_at    = params[:created_at]
    @updated_at    = params[:created_at]
    @customer_repo = customer_repo
  end

  def merchants
    customer_repo.find_customers_merchants(customer_id)
  end

end
