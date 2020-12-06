input = File.read("input.txt", chomp: true).split("\n\n")

puts input.map{|a| a.split("\n")}.map{|b| b.map{|c| c.split("")}}.map{|d| d.inject(:&)}.flatten.count
