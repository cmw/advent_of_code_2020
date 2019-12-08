require_relative 'advent_data'
require_relative 'advent5_2calculation'

data = AdventData.new(day: 7, session: ARGV[0]).get

prepared_array = data.first.split(',').map(&:to_i)
phase_settings = (0..4).to_a.permutation.to_a

thruster_signal = phase_settings.map do |phase_setting|
  phase_setting.reduce(0) do |result, phase_input|
    Advent5_2Calculation.new(instructions: prepared_array, input: [phase_input, result]).calculate.last
  end
end

p thruster_signal.max
