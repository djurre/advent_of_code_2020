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

  def seat_at(i, j)
    if i < 0 || i >= seats.size || j < 0 || j >= seats.first.size
      FLOOR
    else
      seats[i][j]
    end
  end

  def neighbours(i, j)
    (-1..1).filter_map do |a|
      (-1..1).filter_map do |b|
        next if a == 0 && b == 0
        seat_at(i + a, j + b)
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
        elsif seat == OCC && neighbours.count(OCC) >= 4
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