input = File.readlines("input.txt", chomp: true).slice_before { |l| l.include?("Tile") }.map { |t| t[0..10] }

class Tile
  attr_accessor :tile
  attr_accessor :id

  def initialize(tile)
    self.id = tile.delete_at(0).match(/(\d+)/).captures[0].to_i
    self.tile = tile
  end

  def top
    @top ||= tile[0]
  end

  def bottom
    @bottom ||= tile[9]
  end

  def left
    @left ||= tile.map { |r| r[0] }.join
  end

  def right
    @right ||= tile.map { |r| r[9] }.join
  end

  def sides
    @sides ||= [
      top, top.reverse,
      bottom, bottom.reverse,
      left, left.reverse,
      right, right.reverse]
  end

  def matches?(other_tile)
    false if self.id == other_tile.id
    (self.sides & other_tile.sides).any?
  end
end

tiles = input.map { |i| Tile.new(i) }

corners = tiles.select do |tile|
  tiles.count do |other_tile|
    next if tile.id == other_tile.id
    tile.matches?(other_tile)
  end == 2
end

pp corners.map(&:id).inject(:*)
