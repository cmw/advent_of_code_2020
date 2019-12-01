require_relative 'advent_data'

data = AdventData.new(day: 1, session: ARGV[0]).get

modules_fuel = data.map { |module_mass| module_mass.to_i / 3 - 2 }

def calc_fuel(mass)
  fuel = mass / 3 - 2
  return [] if fuel <= 0
  [fuel] + calc_fuel(fuel)
end

modules_added_fuel = modules_fuel.map { |fuel| calc_fuel(fuel) }.flatten.reduce(&:+)
modules_total_fuel = modules_fuel.reduce(&:+)

puts modules_total_fuel + modules_added_fuel
