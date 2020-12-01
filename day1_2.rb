require_relative 'advent_data'

data = AdventData.new(day: 1).get

data.map(&:to_i).combination(3) do |elements|
  next unless elements.reduce(:+) == 2020
  puts elements.reduce(:*)
  break
end