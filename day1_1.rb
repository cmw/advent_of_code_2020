require_relative 'advent_data'

def find_sum(sum, data, left = 0, right = -1)
  x = data[left] + data[right]

  return data[left], data[right] if x == sum # check if it fits

  if x > sum
    right = right - 1 # move right cursor left
  else
    left = left + 1 # move left cursor right
  end

  find_sum(sum, data, left, right) # check again
end

data = AdventData.new(day: 1).get

data = data.sort.map(&:to_i)
puts find_sum(2020, data).reduce(:*)