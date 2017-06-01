require './test/test_helper'
require './lib/invoice'

class InvoiceTest < Minitest::Test

  attr_reader :i

  def setup
      @i = Invoice.new({:id          => 6,
                       :customer_id => 7,
                       :merchant_id => 8,
                       :status      => "pending",
                       :created_at  => Time.now,
                       :updated_at  => Time.now,})
  end
end
