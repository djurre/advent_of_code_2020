input = File.readlines("input.txt", chomp: true)

line_length = input.first.size
x = 0

result = input.count do |line|
  tree = line[x%line_length] == "#"
  x += 3
  tree
end

puts result