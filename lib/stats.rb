

module Stats
  def average(info)
    (info.reduce(:+)/info.count.to_f).round(2)
  end
  def average_invoices_per_merchant
    average(merchants.map {|mechant| merchant.invoices.count})
  end
  def variance(info)
    current_av = average(info)
    info.map {|num| (num-current_av)**2}
  end
  def standard_deviation(info)
    average = average(info)
    variance = variance(info)
    Math.sqrt(average(variance))
  end
end
