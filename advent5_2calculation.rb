class Advent5_2Calculation
  def initialize(instructions:, input:)
    @instructions = instructions
    @input        = input
  end

  def calculate
    prepared_array = instructions.clone
    index          = 0
    output         = 0

    while index < prepared_array.length do
      opcode      = prepared_array[index] % 100
      first_mode  = prepared_array[index].to_s.reverse[2].to_i
      second_mode = prepared_array[index].to_s.reverse[3].to_i

      case opcode
      when 1
        first_param_value  = get_value(first_mode, prepared_array[index + 1], prepared_array)
        second_param_value = get_value(second_mode, prepared_array[index + 2], prepared_array)
        output_index       = prepared_array[index + 3]

        prepared_array[output_index] = first_param_value + second_param_value

        index += 4
      when 2
        first_param_value  = get_value(first_mode, prepared_array[index + 1], prepared_array)
        second_param_value = get_value(second_mode, prepared_array[index + 2], prepared_array)
        output_index       = prepared_array[index + 3]

        prepared_array[output_index] = first_param_value * second_param_value

        index += 4
      when 3
        output_index                 = prepared_array[index + 1]
        prepared_array[output_index] = input.shift

        index += 2
      when 4
        output = get_value(first_mode, prepared_array[index + 1], prepared_array)

        index += 2
      when 5
        first_param_value  = get_value(first_mode, prepared_array[index + 1], prepared_array)
        second_param_value = get_value(second_mode, prepared_array[index + 2], prepared_array)

        first_param_value.zero? ? index += 3 : index = second_param_value
      when 6
        first_param_value  = get_value(first_mode, prepared_array[index + 1], prepared_array)
        second_param_value = get_value(second_mode, prepared_array[index + 2], prepared_array)

        first_param_value.zero? ? index = second_param_value : index += 3
      when 7
        first_param_value  = get_value(first_mode, prepared_array[index + 1], prepared_array)
        second_param_value = get_value(second_mode, prepared_array[index + 2], prepared_array)
        output_index       = prepared_array[index + 3]

        prepared_array[output_index] = (first_param_value < second_param_value ? 1 : 0 )

        index += 4
      when 8
        first_param_value  = get_value(first_mode, prepared_array[index + 1], prepared_array)
        second_param_value = get_value(second_mode, prepared_array[index + 2], prepared_array)
        output_index       = prepared_array[index + 3]

        prepared_array[output_index] = (first_param_value == second_param_value ? 1 : 0 )

        index += 4
      when 99
        break
      else
        puts 'Error!'
        break
      end
    end

    output
  end

  private

  attr_reader :instructions, :input

  def get_value(mode, param, array)
    case mode
    when 0
      array[param]
    when 1
      param
    end
  end
end
