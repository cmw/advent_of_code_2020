require_relative 'advent_data'

data = AdventData.new(day: 12).get

class Boat
  attr :compass

  def initialize
    @lng_distance = 0 # +e -w
    @lat_distance = 0 # +n -s
    @lng_waypoint = 10 # +e -w
    @lat_waypoint = 1 # +n -s
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
    turns = chars[1..-1].to_i / 90
    case chars[0]
    when 'R'
      turns.times do
        @lat_waypoint, @lng_waypoint = -@lng_waypoint, @lat_waypoint
      end
    when 'L'
      turns.times do
        @lat_waypoint, @lng_waypoint = @lng_waypoint, -@lat_waypoint
      end
    end
  end

  def move(chars)
    distance = chars[1..-1].to_i
    case chars[0]
    when 'E'
      @lng_waypoint += distance
    when 'N'
      @lat_waypoint += distance
    when 'W'
      @lng_waypoint -= distance
    when 'S'
      @lat_waypoint -= distance
    when 'F'
      distance.times do
        @lng_distance += @lng_waypoint
        @lat_distance += @lat_waypoint
      end
    end
  end

  def manhattan
    @lng_distance.abs + @lat_distance.abs
  end
end

boaty_mc_boatface = Boat.new
boaty_mc_boatface.parse data
puts boaty_mc_boatface.manhattan