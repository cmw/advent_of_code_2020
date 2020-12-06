require_relative 'advent_data'

data = AdventData.new(day: 6).get

grouped_answers = [[]]

data.each.with_object(grouped_answers) do |line, answer_data|
  if line.empty?
    answer_data << []
  else
    dataset = line.split('')
    answer_data.last << dataset
  end
end

puts grouped_answers.map { |as| as.flatten.uniq.count }.sum
puts grouped_answers.map { |as| as.reduce(as.first, :&).count }.sum
