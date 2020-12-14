require_relative 'advent_data'

data = AdventData.new(day: 12).get

class Boat
  attr :compass

  def initialize
    @compass = [:e, :n, :w, :s]
    @lng_distance = 0 # +e -w
    @lat_distance = 0 # +n -s
  end

  def parse(data)
    data.each do |line|
      case line[0]
      when 'R', 'L'
        turn line
      when 'E', 'N', 'W', 'S', 'F'
        move line
      end
    end
  end

  def turn(chars)
    turns = 1
    if chars[0] == 'R'
      turns =  -1
    end
    turns *= (chars[1..-1].to_i / 90)
    @compass = @compass.rotate(turns)
  end

  def move(chars)
    distance = chars[1..-1].to_i
    case chars[0]
    when 'E'
      @lng_distance += distance
    when 'N'
      @lat_distance += distance
    when 'W'
      @lng_distance -= distance
    when 'S'
      @lat_distance -= distance
    when 'F'
      move(current_direction.to_s.upcase + distance.to_s)
    end
  end

  def current_direction
    @compass.first
  end

  def manhattan
    @lng_distance.abs + @lat_distance.abs
  end
end

boaty_mc_boatface = Boat.new
boaty_mc_boatface.parse data
puts boaty_mc_boatface.manhattan