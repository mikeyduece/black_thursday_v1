module Stats



  def average(info)
    (info.reduce(:+)/info.count.to_f).round(2)
  end


  def variance(info)
    info.map {|num| (num-average)**2}
  end

  def standard_deviation(info)
    mean = average(info)
    var  = variance(info)
    Math.sqrt(mean(var))
  end

  def average_invoices_per_merchant
    average(merchants.map {|mechant| merchant.invoices.count})
  end

  def top_merchant_by_invoice_count
    mean   = average_invoices_per_merchant
    cutoff = average + (standard_deviation ** 2)
    merchants.find_all {|merchant| merchant.invoices > cutoff}
  end

  def bottom_merchant_by_invoice
    mean   = average_invoices_per_merchant
    cutoff = average - (standard_deviation **2)
    merchants.find_all {|merchant| merchant.invoices < cutoff}
  end

  def average_invoices_per_merchant_standard_deviation(info)
    standard_deviation(merchants.map {|merchant| merchants.invoices.count})
  end

  def top_days_by_invoice_count
    invoice_day.reduce({}) do |val, day|
      val[day] = 0 if val[day].nil?
      val[day] += 1
      val
    end
  end

  def invoice_day
    invoices.map {|invoice| Date::DAYNAMES [invoice.created_at.wday]}
  end

  def invoice_status
    
  end

end
