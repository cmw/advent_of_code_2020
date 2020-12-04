require_relative 'advent_data'

data = AdventData.new(day: 4).get

passport_data = [{}]

required_keys = %w(byr iyr eyr hgt hcl ecl pid)# cid

data.each.with_object(passport_data) do |line, pp_data|
  if line.chomp.empty?
    pp_data << {}
  else
    dataset = line.split(' ').map{ |tuple| tuple.split(':') }
    pp_data.last.merge!(Hash[dataset])
  end
end

# def passport_data.reject!(*args, &block)
#   r = super
#   puts count
#   r
# end
#
# def passport_data.select!(*args, &block)
#   r = super
#   puts count
#   r
# end

# discard missing keys
passport_data.reject! { |set| (required_keys - set.keys).any? }

# discard years
passport_data.select! { |set| set.fetch_values('byr', 'iyr', 'eyr').all? { |x| x =~ /^\d{4}$/ } }
passport_data.select! { |set| (1920..2002).include?(set['byr'].to_i) }
passport_data.select! { |set| (2010..2020).include?(set['iyr'].to_i) }
passport_data.select! { |set| (2020..2030).include?(set['eyr'].to_i) }

# discard colors
passport_data.select! { |set| %w(amb blu brn gry grn hzl oth).include? set['ecl'] }
passport_data.select! { |set| set['hcl'] =~ /^\#[0-9a-f]{6}$/ }

# discard pid
passport_data.select! { |set| set['pid'] =~ /^\d{9}$/ }

# discard height
passport_data.select! { |set| set['hgt'] =~ /^((\d{3}cm)|(\d{2}in))$/ }
passport_data.select! do |set|
  if set['hgt'][-2..-1] == 'cm'
    (150..193).include? set['hgt'][0..2].to_i
  else
    (59..76).include? set['hgt'][0..1].to_i
  end
end

# count what's left
pp passport_data.count