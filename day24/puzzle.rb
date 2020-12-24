input = File.readlines("input.txt", chomp: true).map { |i| i.scan(/(se|sw|ne|nw|w|e)/).flatten }
WHITE = 1
BLACK = -1

tiles = Hash.new(WHITE)

NEIGHBOURS = { "ne" => [0, 1, -1], "nw" => [1, 0, -1], "se" => [-1, 0, 1], "sw" => [0, -1, 1], "e" => [-1, 1, 0], "w" => [1, -1, 0] }

input.each do |directions|
  coords = [0, 0, 0]
  directions.each do |direction|
    coords = coords.zip(NEIGHBOURS[direction]).map(&:sum)
  end
  tiles[coords] *= -1
end

pp "Part 1:"
pp tiles.values.count(BLACK)



100.times do
  new_tiles = Marshal.load(Marshal.dump(tiles))
  tiles_to_check = (tiles.keys + tiles.keys.flat_map { |coords| NEIGHBOURS.values.map { |direction| coords.zip(direction).map(&:sum) } }).uniq

  tiles_to_check.each do |coords|
    black_neighbours = NEIGHBOURS.values.count do |neighbour|
      tiles[coords.zip(neighbour).map(&:sum)] == BLACK
    end

    new_tiles[coords] = WHITE if tiles[coords] == BLACK && (black_neighbours == 0 || black_neighbours > 2)
    new_tiles[coords] = BLACK if tiles[coords] == WHITE && black_neighbours == 2
  end

  tiles = new_tiles
end

pp "Part 2:"
pp tiles.values.count(BLACK)