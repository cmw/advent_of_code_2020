require_relative 'advent_data'
require 'matrix'

data = AdventData.new(day: 3).get

data = data.map do |line|
  line.gsub('.', '0')
      .gsub('#', '1')
      .split('')
      .map(&:to_i) # turn the map into a matrix
end

@data_matrix = Matrix.rows(data)

# Starting point of traversal matrix
@skip_row = Array.new(@data_matrix.column_count){ 0 }
@step = @skip_row.dup
@step[0] = 1

def calculate_path_length(right, down)
  # Building traversal matrix
  step_matrix = (0...@data_matrix.row_count).map do |index|
    if index % down == 0
      @step.rotate(-((index * right) / down))
    else 
      @skip_row
    end
  end
  step_matrix = Matrix.rows(step_matrix)

  @data_matrix.hadamard_product(step_matrix).to_a.flatten.sum
end

paths = [[1,1], [3,1], [5,1], [7,1], [1,2]]

puts paths.map {|r,d| calculate_path_length(r,d)}.reduce(:*)

