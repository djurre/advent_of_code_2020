class Puzzle
  attr_accessor :seats

  FLOOR = "."
  EMPTY = "L"
  OCC = "#"

  def initialize
    self.seats = File.readlines("input.txt", chomp: true).map { |s| s.split('') }

    while seats.flatten != cycle.flatten
      self.seats = cycle
    end

    pp seats.flatten.count(OCC)
  end

  def to_s
    seats.each { |s| pp s.join }
  end

  def neighbour(i, j, i_dir, j_dir)
    found = FLOOR
    while true
      i += i_dir
      j += j_dir
      if i < 0 || i >= seats.size || j < 0 || j >= seats.first.size
        break
      end

      if seats[i][j] == OCC || seats[i][j] == EMPTY
        found = seats[i][j]
        break
      end
    end

    found
  end

  def neighbours(i, j)
    (-1..1).filter_map do |i_dir|
      (-1..1).filter_map do |j_dir|
        next if i_dir == 0 && j_dir == 0
        neighbour(i, j, i_dir, j_dir)
      end
    end.flatten
  end

  def cycle
    new_seats = Marshal.load(Marshal.dump(seats))
    seats.each_with_index do |row, row_index|
      row.each_with_index do |seat, seat_index|
        neighbours = neighbours(row_index, seat_index)
        if seat == EMPTY && neighbours.count(OCC) == 0
          new_seats[row_index][seat_index] = OCC
        elsif seat == OCC && neighbours.count(OCC) >= 5
          new_seats[row_index][seat_index] = EMPTY
        else
          new_seats[row_index][seat_index] = seat
        end
      end
    end
    new_seats
  end

end

Puzzle.new