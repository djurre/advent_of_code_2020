input = File.readlines("input.txt")

result = input.count do |line|
  index1, index2, char, password = /^(\d+)-(\d+) ([a-z]): ([a-z]+)$/.match(line).captures
  [password[index1.to_i - 1], password[index2.to_i - 1]].count(char) == 1
end

puts result