require_relative 'advent_data'

data = AdventData.new(day: 9).get.map(&:to_i)

wrong_number = data[25..-1].each.with_index do |line, index|
  if data[(index)..(index + 24)].combination(2).map(&:sum).none? { |s| s == line }
    break(line)
  end
end

puts wrong_number

tuple = (2..(wrong_number/10)).each do |length|
  r = (0..(data.count - length)).each do |index|
    set = data[index, length]
    break(set) if set.sum == wrong_number
  end
  break(r) if r.size == length
end

puts tuple.min + tuple.max