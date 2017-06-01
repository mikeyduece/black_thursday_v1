require 'csv'

class Merchant

  attr_reader :name, :id

  def initialize(params,parent=nil)
    @name = params[:name]
    @id = params[:id]

  end

end
