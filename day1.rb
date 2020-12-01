require_relative 'advent_data'

data = AdventData.new(day: 1).get

def find_product(data, number_of_elements)
  data.map(&:to_i).combination(number_of_elements) do |elements|
    next unless elements.reduce(:+) == 2020
    puts elements.reduce(:*)
    break
  end
end

find_product(data, 2)
find_product(data, 3)