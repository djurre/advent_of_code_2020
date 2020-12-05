input = File.readlines("input.txt", chomp: true)

puts input.map { |code| code.gsub(/\w/, { "F" => 0, "B" => 1, "L" => 0, "R" => 1 }) }.map { |b| b.to_i(2) }.sort.each_cons(2).detect { |d| d[1] - d[0] == 2 }[0] + 1