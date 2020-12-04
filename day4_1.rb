require_relative 'advent_data'

data = AdventData.new(day: 4).get

passport_data = [{}]

required_keys = %w(byr iyr eyr hgt hcl ecl pid)# cid

data.each.with_object(passport_data) do |line, pp_data|
  if line.empty?
    pp_data << {}
  else
    dataset = line.split(' ').map{ |tuple| tuple.split(':') }
    pp_data.last.merge!(Hash[dataset])
  end
end

puts passport_data.reject { |set| (required_keys - set.keys).any? }.count