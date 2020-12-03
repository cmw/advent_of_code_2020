require_relative 'advent_data'
require 'matrix'

data = AdventData.new(day: 3).get

data = data.map do |line|
  line.gsub('.', '0')
      .gsub('#', '1')
      .split('')
      .map(&:to_i) # turn the map into a matrix
end

data_matrix = Matrix.rows(data)

# Starting point of traversal matrix
step = Array.new(data_matrix.column_count){ 0 }
step[0] = 1

# Building traversal matrix
step_matrix = (0...data_matrix.row_count).map do |index|
  step.rotate(-index * 3)
end
step_matrix = Matrix.rows(step_matrix)

path = data_matrix.hadamard_product(step_matrix)
puts path.to_a.flatten.sum

