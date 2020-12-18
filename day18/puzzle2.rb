class Integer
  def **(op)
    self + op
  end
end

puts File.readlines("input.txt", chomp: true).sum { |line| eval(line.gsub("+", "**")) }
