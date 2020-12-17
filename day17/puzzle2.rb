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
        pocket[coords(x_index, y_index, 0, 0)] = { value: point, x: x_index.to_i, y: y_index.to_i, z: 0, w: 0 }
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
      num_neighbours = num_neighbours(data[:x], data[:y], data[:z], data[:w])
      if data[:value] == ACTIVE && num_neighbours != 2 && num_neighbours != 3
        new_pocket[coord][:value] = INACTIVE
      elsif data[:value] == INACTIVE && num_neighbours == 3
        new_pocket[coord][:value] = ACTIVE
      end
    end

    self.pocket = new_pocket
  end

  def num_neighbours(x, y, z, w)
    neighbours(x, y, z, w).count do |neighbour|
      pocket[coords(neighbour[0], neighbour[1], neighbour[2], neighbour[3])][:value] == ACTIVE
    end
  end

  def neighbours(x, y, z, w)
    (-1..1).flat_map do |x1|
      (-1..1).flat_map do |y1|
        (-1..1).flat_map do |z1|
          (-1..1).filter_map do |w1|
            next if x1 == 0 && y1 == 0 && z1 == 0 && w1 == 0
            [x + x1, y + y1, z + z1, w + w1]
          end
        end
      end
    end
  end

  def pad
    new_pocket = Marshal.load(Marshal.dump(pocket))
    pocket.each do |coord, data|
      neighbours(pocket[coord][:x], pocket[coord][:y], pocket[coord][:z], pocket[coord][:w]).each do |neighbour|
        unless pocket.key?(coords(neighbour[0], neighbour[1], neighbour[2], neighbour[3]))
          new_pocket[coords(neighbour[0], neighbour[1], neighbour[2], neighbour[3])] = {
            value: INACTIVE,
            x: neighbour[0],
            y: neighbour[1],
            z: neighbour[2],
            w: neighbour[3] }
        end
      end
    end

    self.pocket = new_pocket
  end

  def coords(x, y, z, w)
    "#{x}|#{y}|#{z}|#{w}"
  end

  def range(dir)
    range = pocket.values.map { |point| point[dir] }
    (range.min..range.max)
  end

end


Pocket.new