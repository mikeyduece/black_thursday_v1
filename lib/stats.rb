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

  def invoice_day #take out time parse bs its in invoice
    @se.invoices.all.map {|invoice| Date::DAYNAMES[Time.parse(invoice.created_at).wday]}
  end

  def top_days_via_invoices
    total_invoices_by_day = {}
    total_invoices_by_day =  invoice_day.reduce({}) do |val, day|
      val[day] = 0 if val[day].nil?
      val[day] += 1
      val
    end
    total_invoices_by_day
    invoices_by_day = total_invoices_by_day.values
    bar = average(invoices_by_day) + standard_deviation(invoices_by_day)
    top_days = []
    total_invoices_by_day.each { |key, value| top_days << key if value > bar}
    top_days
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


  def num_items_per_merchant
    merch_ids = merch_id_array
      arr_n_items_by_merch =  []
      merch_ids.each do |id|
      arr_n_items_by_merch << @se.items.find_all_by_merchant_id(id).length
    end
    arr_n_items_by_merch
  end

  def merch_with_num_of_items_hash
    merch_name_array = []
    @se.merchants.all.each do |merch|
      merch_name_array << merch.name
    end
    nested_arr = merch_name_array.zip(num_items_per_merchant)
    hash = Hash[nested_arr]
  end

  def merch_id_array
    merch_id_array = []
    @se.merchants.all.each do |merch|
      merch_id_array << merch.id
    end
    merch_id_array
  end
end
