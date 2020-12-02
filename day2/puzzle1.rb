input = File.readlines("input.txt")

result = input.count do |line|
  count_min, count_max, char, password = /^(\d+)-(\d+) ([a-z]): ([a-z]+)$/.match(line).captures
  (count_min.to_i..count_max.to_i) === password.count(char)
end

puts result