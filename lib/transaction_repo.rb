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
      if transaction.id == id
        return transaction
      end
      nil
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all_invoice_ids = all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
    return [] if all_invoice_ids.empty?
    return all_invoice_ids
  end

  def find_all_by_credit_card_number(num)
    all_cc_nums = all.find_all do |transaction|
      transaction.credit_card_number == num
    end
    return [] if all_cc_nums.empty?
    return all_cc_nums
  end

  def find_all_by_result(info)
    all_results = all.find_all do |transaction|
      transaction.result == info
    end
    return [] if all_results.empty?
    return all_results
  end
end
