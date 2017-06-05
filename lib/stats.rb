require 'time'

module Stats
  def average(info)
    (info.reduce(:+)/info.count.to_f).round(2)
  end

  def variance(info)
    current_av = average(info)
    info.map {|num| (num-current_av)**2}
  end

  def standard_deviation(info)
    average = average(info)
    variance = variance(info)
    Math.sqrt(average(variance)).round(2)
  end


  def invoice_day
    @se.invoices.all.map {|invoice| Date::DAYNAMES[Time.parse(invoice.created_at).wday]}
  end

  def pending_invoices
    total =  @se.invoices.all.length
    pending = 0
    @se.invoices.all.each { |invoice| pending += 1 if invoice.status == "pending"}
    pending_percent = (pending.to_f / total.to_f) * 100
    pending_percent.round(2)
  end

  def shipped_invoices
    total =  @se.invoices.all.length
    shipped = 0
    @se.invoices.all.each { |invoice| shipped += 1 if invoice.status == "shipped"}
    shipped_percent =  (shipped.to_f / total.to_f) * 100
    shipped_percent.round(2)
  end

  def returned_invoices
    total =  @se.invoices.all.length
    returned = 0
    @se.invoices.all.each { |invoice| returned += 1 if invoice.status == "returned"}
    returned_percent =  (returned.to_f / total.to_f) * 100
    returned_percent.round(2)
  end





end


#check the below

#
# module Stats
#
#
#
#   def average(info)
#     (info.reduce(:+)/info.count.to_f).round(2)
#   end
#
#
#   def variance(info)
#     info.map {|num| (num-average)**2}
#   end
#
#   def standard_deviation(info)
#     mean = average(info)
#     var  = variance(info)
#     Math.sqrt(mean(var))
#   end
#
#   def average_invoices_per_merchant
#     average(merchants.map {|mechant| merchant.invoices.count})
#   end
#
#   def top_merchant_by_invoice_count
#     mean   = average_invoices_per_merchant
#     cutoff = average + (standard_deviation ** 2)
#     merchants.find_all {|merchant| merchant.invoices > cutoff}
#   end
#
#   def bottom_merchant_by_invoice
#     mean   = average_invoices_per_merchant
#     cutoff = average - (standard_deviation *2)
#     merchants.find_all {|merchant| merchant.invoices < cutoff}
#   end
#
#   def average_invoices_per_merchant_standard_deviation(info)
#     standard_deviation(merchants.map {|merchant| merchants.invoices.count})
#   end
#
#   def top_days_by_invoice_count
#     invoice_day.reduce({}) do |val, day|
#       val[day] = 0 if val[day].nil?
#       val[day] += 1
#       val
#     end
#   end
#
#   def invoice_day
#     invoices.map {|invoice| Date::DAYNAMES[invoice.created_at.wday]}
#   end
#
#   def invoice_status
#
#   end
#
# end
