require 'csv'
require_relative 'customer'

class CustomerRepo
  attr_reader :all, :sales_engine

  def initialize(filename, sales_engine=nil)
    @all_customers = []
    @sales_engine = sales_engine
    open_all_customers(filename)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def open_all_customers(filename)
    CSV.foreach filename, headers: true, header_converters: :symbol do |row|
      @all_customers << Customer.new(row,self)
    end
    @all_customers
  end

  def find_customers_merchants(id)
    sales_engine.find_merchants_of_customers(id)
  end

  def all
    @all_customers
  end

  def find_by_id(id)
    all.find do |customer|
      if customer.id == id
        return customer
      end
      nil
    end
  end

  def find_all_by_first_name(fname)
    first_names = all.find_all do |customer|
      customer.first_name.downcase.include?(fname.downcase.to_s)
    end
    return [] if first_names.empty?
    return first_names
  end

  def find_all_by_last_name(lname)
    last_names =all.find_all do |customer|
      customer.last_name.downcase.include?(lname.downcase.to_s)
    end
    return [] if last_names.empty?
    return last_names
  end
end
