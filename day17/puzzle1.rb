class Pocket
  ACTIVE = "#"
  INACTIVE = "."

  attr_accessor :pocket

  def initialize
    input = File.readlines("input.txt", chomp: true)
    self.pocket = {}
    self.pocket.default = { value: INACTIVE }

    input.each_with_index do |line, y_index|
      line.split('').each_with_index do |point, x_index|
        pocket[coords(x_index, y_index, 0)] = { value: point, x: x_index.to_i, y: y_index.to_i, z: 0 }
      end
    end

    6.times do
      step
    end

    pp pocket.values.count { |cube| cube[:value] == ACTIVE }
  end

  def step
    pad
    new_pocket = Marshal.load(Marshal.dump(pocket))

    pocket.each do |coord, data|
      num_neighbours = num_neighbours(data[:x], data[:y], data[:z])
      if data[:value] == ACTIVE && num_neighbours != 2 && num_neighbours != 3
        new_pocket[coord][:value] = INACTIVE
      elsif data[:value] == INACTIVE && num_neighbours == 3
        new_pocket[coord][:value] = ACTIVE
      end
    end

    self.pocket = new_pocket
  end

  def to_s
    range(:z).each do |z|
      puts "z: #{z}"
      range(:y).each do |y|
        line = range(:x).map do |x|
          pocket[coords(x, y, z)][:value]
        end.join
        puts line
      end
      puts "\n"
    end
  end

  def num_neighbours(x, y, z)
    neighbours(x, y, z).count do |neighbour|
      pocket[coords(neighbour[0], neighbour[1], neighbour[2])][:value] == ACTIVE
    end
  end

  def neighbours(x, y, z)
    (-1..1).flat_map do |x1|
      (-1..1).flat_map do |y1|
        (-1..1).filter_map do |z1|
          next if x1 == 0 && y1 == 0 && z1 == 0
          [x + x1, y + y1, z + z1]
        end
      end
    end
  end

  def pad
    new_pocket = Marshal.load(Marshal.dump(pocket))
    pocket.each do |coord, data|
      neighbours(pocket[coord][:x], pocket[coord][:y], pocket[coord][:z]).each do |neighbour|
        unless pocket.key?(coords(neighbour[0], neighbour[1], neighbour[2]))
          new_pocket[coords(neighbour[0], neighbour[1], neighbour[2])] = {
            value: INACTIVE,
            x: neighbour[0],
            y: neighbour[1],
            z: neighbour[2] }
        end
      end
    end

    self.pocket = new_pocket
  end

  def coords(x, y, z)
    "#{x}|#{y}|#{z}"
  end

  def range(dir)
    range = pocket.values.map { |point| point[dir] }
    (range.min..range.max)
  end

end

Pocket.new