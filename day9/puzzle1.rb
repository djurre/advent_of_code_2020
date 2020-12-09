input = File.readlines("input.txt", chomp: true).map(&:to_i)

pre = 25

res = (pre..(input.size - 1)).map do |i|
  input[i] if input[i - pre, pre].combination(2).map { |a, b| a+b if a + b == input[i]}.compact.empty?
end.compact.first

pp res
