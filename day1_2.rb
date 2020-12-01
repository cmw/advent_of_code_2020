require_relative 'advent_data'

data = AdventData.new(day: 1).get

data.combination(3) do |a,b,c|
  next unless a+b+c == 2020
  puts [a,b,c].reduce(:*)
end