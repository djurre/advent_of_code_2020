ACTIVE = "#"
INACTIVE = "."

def calculate(dimensions)
  @pocket = Hash.new(INACTIVE)
  @dimensions = dimensions
  File.readlines("input.txt", chomp: true).each_with_index { |line, y| line.split('').each_with_index { |point, x| @pocket[[x, y].fill(0, 2, @dimensions - 2)] = point } }
  6.times { step }
  @pocket.values.count(ACTIVE)
end

def step
  coords_to_step = (@pocket.keys + @pocket.keys.flat_map { |pocket| neighbours(pocket) }).uniq
  new_pocket = Marshal.load(Marshal.dump(@pocket))

  coords_to_step.each do |coord|
    num_neighbours = neighbours(coord).count { |n| @pocket[n] == ACTIVE }
    if @pocket[coord] == ACTIVE && ![2, 3].include?(num_neighbours)
      new_pocket[coord] = INACTIVE
    elsif @pocket[coord] == INACTIVE && num_neighbours == 3
      new_pocket[coord] = ACTIVE
    end
  end

  @pocket = new_pocket
end

def neighbours(coord)
  [-1, 0, 1].repeated_permutation(@dimensions).filter_map do |neighbour|
    next if neighbour.uniq == [0]
    coord.zip(neighbour).map(&:sum)
  end
end

pp calculate(3)
pp calculate(4)