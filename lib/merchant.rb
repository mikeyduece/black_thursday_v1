require 'csv'

class Merchant

  attr_reader :name,
              :id,
              :merchant_repository,
              :created_at,
              :month_created

  def initialize(params, merchant_repository=nil)
    @name = params[:name]
    @id = params[:id].to_i
    @created_at = params[:created_at]
    @merchant_repository = merchant_repository
  end

  def invoices
    merchant_repository.merchant_repository_invoices(id)
  end

  def items
    merchant_repository.merchant_repository_items(id)
  end

  def customers
    merchant_repository.find_merchants_customers(id)
  end

  def month_created
    month = created_at.split('-')[1].strip.to_i
    case month
    when 1 then 'January'
    when 2 then 'February'
    when 3 then 'March'
    when 4 then 'April'
    when 5 then 'May'
    when 6 then 'June'
    when 7 then 'July'
    when 8 then 'August'
    when 9 then 'September'
    when 10 then 'October'
    when 11 then 'November'
    when 12 then 'December'
    end
  end

end
