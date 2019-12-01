require_relative 'advent_data'

data = AdventData.new(day: 1, session: ARGV[0]).get

modules_fuel = data.map { |module_mass| module_mass.to_i / 3 - 2 }

total_fuel = modules_fuel.reduce(&:+)

puts total_fuel
