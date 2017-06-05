require 'csv'
require_relative 'transaction'

class TransactionRepo

  attr_reader :sales_engine, :all

  def initialize(filename, sales_engine=nil)
    @all_transactions = []
    @sales_engine = sales_engine
    open_all_items(filename)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def open_all_items(filename)
    CSV.foreach filename, headers: true, header_converters: :symbol do |row|
      @all_transactions << Transaction.new(row,self)
    end
  end

  def all
    @all_transactions
  end

  def transaction_invoice(invoice_id)
    sales_engine.find_transaction_invoice_by_id(invoice_id)
  end

  def find_by_id(id)
    all.find do |transaction|
      if transaction.id == id.to_s
        return transaction
      end
      nil
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all_invoice_ids = []
    all.find_all do |transaction|
      if transaction.invoice_id == invoice_id.to_s
        all_invoice_ids << transaction
      end
    end
    return [] if all_invoice_ids.empty?
    return all_invoice_ids
  end

  def find_all_by_cc_num(num)
    all_cc_nums = []
    all.find_all do |transaction|
      if transaction.cc_num == num.to_s
        all_cc_nums << transaction
      end
    end
    return [] if all_cc_nums.empty?
    return all_cc_nums
  end

  def find_all_by_result(info)
    all_results = []
    all.find_all do |transaction|
      if transaction.result == info
        all_results << transaction
      end
    end
    return [] if all_results.empty?
    return all_results
  end
end
