require_relative 'advent_data'
require 'matrix'

data = AdventData.new(day: 5).get
data = data.map do |line|
  line.gsub('F', '0')
      .gsub('B', '1')
      .gsub('L', '0')
      .gsub('R', '1')
      .to_i(2) # turn the line into a number in base 2
end

puts data.max

puts (data.min..data.max).to_a - data 