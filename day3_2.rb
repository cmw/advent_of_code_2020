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
skip_row = Array.new(data_matrix.column_count){ 0 }
step = skip_row.dup
step[0] = 1

# Building traversal matrices
step11_matrix = (0...data_matrix.row_count).map do |index|
  step.rotate(-index * 1)
end
step11_matrix = Matrix.rows(step11_matrix)

step13_matrix = (0...data_matrix.row_count).map do |index|
  step.rotate(-index * 3)
end
step13_matrix = Matrix.rows(step13_matrix)

step15_matrix = (0...data_matrix.row_count).map do |index|
  step.rotate(-index * 5)
end
step15_matrix = Matrix.rows(step15_matrix)

step17_matrix = (0...data_matrix.row_count).map do |index|
  step.rotate(-index * 7)
end
step17_matrix = Matrix.rows(step17_matrix)

step21_matrix = (0...data_matrix.row_count).map do |index|
  if index.odd?
    skip_row
  else 
    step.rotate(-index / 2)
  end
end
step21_matrix = Matrix.rows(step21_matrix)

path_lengths = [
  data_matrix.hadamard_product(step11_matrix).to_a.flatten.sum,
  data_matrix.hadamard_product(step13_matrix).to_a.flatten.sum,
  data_matrix.hadamard_product(step15_matrix).to_a.flatten.sum,
  data_matrix.hadamard_product(step17_matrix).to_a.flatten.sum,
  data_matrix.hadamard_product(step21_matrix).to_a.flatten.sum
]

puts path_lengths.reduce(:*)

