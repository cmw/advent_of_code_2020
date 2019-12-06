require_relative 'advent_data'

data = AdventData.new(day: 6, session: ARGV[0]).get

$paths = []

def look_for_orbits(orbital, data)
  center, orbit = orbital.split(')')
  $paths.last << orbital

  data.select { |set| set.include?(")#{center}") }.each do |new_orbital|
    look_for_orbits(new_orbital, data)
  end
end

data.each do |orbital|
  $paths << []
  look_for_orbits(orbital, data)
end

correct_paths = $paths.select do |path|
  path_string = path.join
  path_string.include?(')YOU') || path_string.include?(')SAN')
end

uniq_orbits = (correct_paths.first - correct_paths.last) + (correct_paths.last - correct_paths.first)

print uniq_orbits.count - 2
