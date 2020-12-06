input = File.read("input.txt", chomp: true).split("\n\n")

puts input.map{|c| c.delete("\n").split("")}.map{|c| c.uniq }.flatten.count