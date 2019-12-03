require_relative 'advent_data'

STARTING_POINT = [0,0]

data = AdventData.new(day: 3, session: ARGV[0]).get

first_wire = data.first.split(',')
second_wire = data.last.split(',')

def build_coordinates(coordinates_array, path)
  case path.slice!(0)
  when 'U'
    path.to_i.times do
      coordinates_array << [coordinates_array.last.first, coordinates_array.last.last + 1]
    end
  when 'D'
    path.to_i.times do
      coordinates_array << [coordinates_array.last.first, coordinates_array.last.last - 1]
    end
  when 'R'
    path.to_i.times do
      coordinates_array << [coordinates_array.last.first + 1, coordinates_array.last.last]
    end
  when 'L'
    path.to_i.times do
      coordinates_array << [coordinates_array.last.first - 1, coordinates_array.last.last]
    end
  end
end

first_wire_coordinates = [STARTING_POINT]

first_wire.each do |path|
  build_coordinates(first_wire_coordinates, path)
end

second_wire_coordinates = [STARTING_POINT]

second_wire.each do |path|
  build_coordinates(second_wire_coordinates, path)
end

intersections = first_wire_coordinates & second_wire_coordinates - [STARTING_POINT]

print intersections.map { |coordinates| coordinates.first.abs + coordinates.last.abs }.min
