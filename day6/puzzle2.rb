input = File.read("input.txt").split("\n\n")

puts input.map { |a| a.split("\n").map { |b| b.split("") } }.map { |c| c.inject(:&) }.flatten.count
