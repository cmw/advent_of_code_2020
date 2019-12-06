require_relative 'advent_data'

data = AdventData.new(day: 6, session: ARGV[0]).get

$checksum = 0

def look_for_orbits(orbital, data)
  center, orbit = orbital.split(')')
  $checksum += 1

  data.select { |set| set.include?(")#{center}") }.each do |new_orbital|
    look_for_orbits(new_orbital, data)
  end
end

data.each do |orbital|
  look_for_orbits(orbital, data)
end

print $checksum
