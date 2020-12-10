require_relative 'advent_data'

data = AdventData.new(day: 10).get.map(&:to_i)

m = data.max + 3 # extra rating for adaptor
n = data.count + 1 # accounting for the adaptor
threes = (m-n) / 2
ones = n - threes

puts ones * threes

def permutations_count(x) # number of permutations of blocks of 1s follow a tribonacci sequence
  case x
  when 1, 2 then 1
  when 3 then 2
  else permutations_count(x-1) + permutations_count(x-2) + permutations_count(x-3)
  end
end

puts (data + [0, m]).sort.slice_when { |a,b| a.succ != b }.map { |x| permutations_count(x.count) }.reduce(:*)