input = File.readlines("input.txt").map(&:to_i)

# puzzle 1
puts input.combination(2).detect{ |a| a.sum == 2020}.inject(:*)

# puzzle 2
puts input.combination(3).detect{ |a| a.sum == 2020}.inject(:*)
