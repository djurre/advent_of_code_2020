input = File.readlines("input.txt", chomp: true).map { |i| i.scan(/(se|sw|ne|nw|w|e)/).sort.flatten }

tiles = Hash.new(-1)

def normalize(directions, d1, d2, result)
  min = [directions.count(d1), directions.count(d2)].min
  min.times { directions.delete_at(directions.find_index(d1)) }
  min.times { directions.delete_at(directions.find_index(d2)) }
  directions.concat([result] * min) if result
end

input.each do |directions|
  normalize(directions, "nw", "sw", "w")
  normalize(directions, "ne", "se", "e")
  normalize(directions, "w", "e", nil)
  normalize(directions, "ne", "sw", nil)
  normalize(directions, "nw", "se", nil)
  normalize(directions, "ne", "w", "nw")
  normalize(directions, "nw", "e", "ne")
  normalize(directions, "se", "w", "sw")
  normalize(directions, "sw", "e", "se")
  directions.sort!

  x_coords = directions.join.count("e") - directions.join.count("w")
  y_coords = directions.join.count("n") - directions.join.count("s")
  tiles[[x_coords, y_coords]] *= -1
end

pp input.tally.values.count { |v| v % 2 == 1 }
