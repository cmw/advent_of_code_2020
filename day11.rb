require_relative 'advent_data'

data = AdventData.new(day: 11).get

data.map!(&:chars)

class Seat
  OCCUPY_THRESHOLD = 5
  attr :adjacent, :occupied

  def initialize
    @adjacent = []
    @occupied = false
  end

  def occupied?
    @occupied
  end

  def occupy!
    @occupied = true
  end

  def vacate!
    @occupied = false
  end

  def toggle_occupation!
    if occupied?
      vacate!
    else
      occupy!
    end
  end

  def add_neighbor(neighbor)
    return unless neighbor.kind_of?(self.class)
    unless @adjacent.include? neighbor
      @adjacent << neighbor
      neighbor.add_neighbor(self)
    end
  end

  def should_be_vacated?
    occupied? && @adjacent.count(&:occupied?) >= OCCUPY_THRESHOLD
  end

  def should_be_occupied?
    !occupied? && @adjacent.none?(&:occupied?)
  end

  def to_s(output_adjacent = false)
    return @adjacent.count.to_s if output_adjacent
    occupied? ? '#' : 'L'
  end
end

class NoSeat
  def occupied?
    false
  end

  def should_be_vacated?
    false
  end

  def should_be_occupied?
    false
  end

  def to_s(_)
    '.'
  end
end

class Room
  attr :grid, :seats

  def initialize(grid, los = false)
    @grid = grid
    initialize_seats(los)
  end

  def initialize_seats(los = false)
    seat_grid = []
    grid.each_with_index do |line, l_idx|
      seat_grid << []
      line.each_with_index do |pos, p_idx|
        if pos == '.'
          seat_grid[l_idx] << NoSeat.new
          next
        end

        s = Seat.new()
        seat_grid[l_idx] << s

        if los
          up_and_left = next_in_los(l_idx, p_idx, seat_grid)
        else
          up_and_left = []
          up_and_left << seat_grid[l_idx][p_idx - 1] if p_idx > 0
          up_and_left += (seat_grid[l_idx - 1][p_idx, 2] || []) if l_idx > 0
          up_and_left << seat_grid[l_idx - 1][p_idx - 1] if p_idx > 0 && l_idx > 0
        end
        up_and_left.compact.each do |neighbor|
          s.add_neighbor(neighbor)
        end
      end
    end
    @seat_grid = seat_grid
    @seats = seat_grid.flatten
  end

  def next_in_los(l_idx, p_idx, grid)
    w = grid[l_idx][0...p_idx].reverse.detect { |x| x.is_a? Seat }
    i = 1
    nw = until l_idx - i < 0 || p_idx - i < 0 do
      s = grid[l_idx - i][p_idx - i]
      break(s) if s.is_a? Seat
      i += 1
      nil
    end
    n = grid[0...l_idx].map{ |l| l[p_idx] }.reverse.detect { |x| x.is_a? Seat }
    i = 1
    ne = until l_idx - i < 0 || p_idx + i >= grid[l_idx - i].length do
      s = grid[l_idx - i][p_idx + i]
      break(s) if s.is_a? Seat
      i += 1
      nil
    end
    [w, nw, n, ne]
  end

  def simulate(runs = -1)
    puts number_of_occupied_seats
    seats_to_change = @seats.select { |seat| seat.should_be_occupied? || seat.should_be_vacated?}
    if seats_to_change.any?
      puts "to change: #{seats_to_change.count}"
      seats_to_change.map(&:toggle_occupation!)
      runs -= 1 if runs > 0
      simulate(runs) unless runs == 0
    end
  end

  def number_of_occupied_seats
    @seats.select(&:occupied?).count
  end
  
  def show(adjacent = false)
    @seat_grid.each do |l|
      if adjacent
        puts l.map{|c|c.to_s(adjacent)}.join
      else
        puts l.join
      end
    end
  end
end

room = Room.new(data, true)
room.simulate(180)
puts room.number_of_occupied_seats