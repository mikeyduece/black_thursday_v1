module Stats

  def average(info)
    (info.reduce(:+)/info.count.to_f).round(2)
  end


  def variance(info)
    info.map {|num| (num-average)**2}
  end

  def standard_deviation
    Math.sqrt(average(variance))
  end

  def average_invoices_per_merchant
    average(merchants.map {|mechant| merchant.invoices.count})
  end

  def top_merchant_by_invoice_count
    mean   = average_invoices_per_merchant
    cutoff = average + (standard_deviation ** 2)
    merchants.map {|merchant| merchant.invoices > cutoff}
  end

  def bottom_merchant_by_invoice
    mean = average_invoices_per_merchant
    cutoff = average - (standard_deviation **2)
    merchants.map {|merchant| merchant.invoices < cutoff}
  end

  def average_invoices_per_merchant_standard_deviation
    
  end
end
