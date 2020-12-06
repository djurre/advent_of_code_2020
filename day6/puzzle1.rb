input = File.read("input.txt").split("\n\n")

puts input.map { |c| c.split(/\n|/) }.map { |c| c.uniq }.flatten.count
