require_relative 'advent_data'

data = AdventData.new(day: 2, session: ARGV[0]).get

prepared_array = data.first.split(',').map(&:to_i)

prepared_array[1] = 12
prepared_array[2] = 2

def get_values_and_output_index(array, index)
  first_input_index = array[index + 1]
  first_input_value = array[first_input_index]

  second_input_index = array[index + 2]
  second_input_value = array[second_input_index]

  output_index = array[index + 3]

  [first_input_value, second_input_value, output_index]
end

prepared_array.each_with_index do |num, index|
  next unless (index % 4).zero?

  case num
  when 1
    first_input_value, second_input_value, output_index = get_values_and_output_index(prepared_array, index)
    prepared_array[output_index] = first_input_value + second_input_value
  when 2
    first_input_value, second_input_value, output_index = get_values_and_output_index(prepared_array, index)
    prepared_array[output_index] = first_input_value * second_input_value
  when 99
    break
  else
    puts 'Error!'
    break
  end
end

print prepared_array[0]
