require 'csv'
# module DataParser
#   def parse_data(filename)
#     handle = CSV.open filename, headers: true, header_converters: :symbol
#     handle.map{ |row| row }
#   end
# end


module DataParser
  def parse_data(filename)
    require "pry"; binding.pry
    filename.map do |key, value|
      [key, (CSV.open file, headers: true, header_converters: :symbol)]
    end
  end
end
