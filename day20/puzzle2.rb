input = File.readlines("input.txt", chomp: true).slice_before { |l| l.include?("Tile") }.map { |t| t[0..10] }

class Tile
  attr_accessor :tile
  attr_accessor :id
  attr_accessor :used
  attr_accessor :size

  def initialize(id, tile)
    self.size = tile.count
    self.id = id
    self.tile = tile
  end

  def without_borders
    tile[1..size - 2].map { |l| l[1..size - 2] }
  end

  def top
    tile[0]
  end

  def bottom
    tile[size - 1]
  end

  def left
    tile.map { |r| r[0] }.join
  end

  def right
    tile.map { |r| r[size - 1] }.join
  end

  def all_orientations
    res = []
    res += all_rotations(tile)
    res += all_rotations(flip_horizontal(tile))
    res += all_rotations(flip_vertical(tile))
    res.uniq.map { |t| Tile.new(id, t) }
  end

  def all_rotations(t)
    (1..4).map do
      t = t.map { |x| x.split('') }.transpose.reverse.map(&:join)
    end
  end

  def flip_vertical(t)
    t.reverse
  end

  def flip_horizontal(t)
    t.map { |r| r.reverse }
  end

  def find_match(direction, other_tile)
    case direction
    when :left
      other_tile.all_orientations.detect { |other| other.right == self.left }
    when :right
      other_tile.all_orientations.detect { |other| other.left == self.right }
    when :top
      other_tile.all_orientations.detect { |other| other.bottom == self.top }
    when :bottom
      other_tile.all_orientations.detect { |other| other.top == self.bottom }
    end
  end

  def find_monster
    inter_monster_distance = size - 20
    monster_size = 3 * 20
    monster = /^..................#..{#{inter_monster_distance}}#....##....##....###.{#{inter_monster_distance}}.#..#..#..#..#..#...$/

    sea = tile.join
    (0..sea.size - size).count { |i| sea[i, 2 * inter_monster_distance + monster_size].match(monster) }
  end
end

def neighbours(coords)
  {
    left: [coords[0] - 1, coords[1]],
    right: [coords[0] + 1, coords[1]],
    bottom: [coords[0], coords[1] - 1],
    top: [coords[0], coords[1] + 1]
  }
end

def generate(tile, coords = [0, 0])
  neighbours(coords).each do |direction, neighbour_coords|
    next if @grid.key?(neighbour_coords)
    @tiles.each do |other_tile|
      next if tile.id == other_tile.id
      next if other_tile.used

      match = tile.find_match(direction, other_tile)
      if match
        @tiles.detect { |t| t.id == match.id }.used = true
        @grid[neighbour_coords] = match
        generate(match, neighbour_coords)
      end
    end
  end
end

@tiles = input.map do |tile|
  id = tile.delete_at(0).match(/(\d+)/).captures[0].to_i
  Tile.new(id, tile)
end

@grid = { [0, 0] => @tiles[0] }
generate(@tiles[0])

x_coords = @grid.keys.map(&:first).sort.uniq
y_coords = @grid.keys.map(&:last).sort.uniq.reverse

sea_map = y_coords.map { |y| x_coords.map { |x| @grid[[x, y]].without_borders } }.flat_map do |r|
  first, *rest = r
  first.zip(*rest)
end.map(&:join)

map = Tile.new(nil, sea_map)
num_monsters = map.all_orientations.filter_map { |orientation| orientation.find_monster }.flatten.sum
num_map = map.tile.flatten.join.count("#")
pp num_map - (num_monsters * 15)
