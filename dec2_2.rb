require_relative 'advent_data'
require_relative 'advent2_1calculation'

REQUIRED_OUTPUT = 19690720

data = AdventData.new(day: 2, session: ARGV[0]).get

memory = data.first.split(',').map(&:to_i)

(0..99).each do |noun|
  (0..99).each do |verb|
    if Advent2_1Calculation.new(memory: memory, noun: noun, verb: verb).calculate == REQUIRED_OUTPUT
      print 100 * noun + verb
      return
    else
      next
    end
  end
end
