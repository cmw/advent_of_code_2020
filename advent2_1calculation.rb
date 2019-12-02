class Advent2_1Calculation
  def initialize(memory:, noun:, verb:)
    @memory = memory
    @noun   = noun
    @verb   = verb
  end

  def calculate
    prepared_array = memory.clone

    prepared_array[1] = noun
    prepared_array[2] = verb

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
        break
      end
    end

    prepared_array[0]
  end

  private

  attr_reader :memory, :noun, :verb

  def get_values_and_output_index(array, index)
    first_input_index = array[index + 1]
    first_input_value = array[first_input_index]

    second_input_index = array[index + 2]
    second_input_value = array[second_input_index]

    output_index = array[index + 3]

    [first_input_value, second_input_value, output_index]
  end
end
