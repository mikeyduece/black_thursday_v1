Module Stats
  def average(info)
    (info.reduce(:+)/info.count.to_f).round(2)
  end

  def average_invoices_per_merchant
    average(merchants.map {|mechant| merchant.invoices.count})
  end

  def variance(info)
    info.map {|num| (num-average)**2}
  end

  def standard_deviation
    Math.sqrt(average(variance))
  end
end
