require_relative 'advent_data'

data = AdventData.new(day: 2).get

def split(data)
  data.map do |el|
    els = el.split(" ")
    els[0] = els[0].split('-')
    els[1] = els[1][0..-2]
    els
  end
end

password_list = split(data)

r = password_list.map do |(low, high), letter, password|
  if [password[low.to_i - 1], password[high.to_i - 1]].join.count(letter) == 1
    1
  else
    0
  end
end.sum

puts r