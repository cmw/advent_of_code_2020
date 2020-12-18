require_relative 'advent_data'

@data = [20,9,11,0,1,2]
# @data = [0,3,6]

@memory = Array.new(0)

# @end = 2020
@end = 30000000

turn = 1
last_value = nil

x = loop do 
  break last_value if turn > @end

  if x = @data[turn - 1]
    new_value = x
  else
    if x = @memory[last_value]
      new_value = turn - x - 1
    else
      new_value = 0
    end
  end

  @memory[last_value.to_i] = turn - 1
  turn += 1
  last_value = new_value
end
puts x