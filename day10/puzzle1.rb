input = File.readlines("input.txt", chomp: true).map(&:to_i)

diffs = ([0] + input.sort + [input.max + 3]).each_cons(2).map { |a, b| b - a }

pp diffs.count(1) * diffs.count(3)
