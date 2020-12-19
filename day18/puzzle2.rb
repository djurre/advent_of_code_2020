# The kind of cheating way
class Integer
  def **(op)
    self + op
  end
end
puts File.readlines("input.txt", chomp: true).sum { |line| eval(line.gsub("+", "**")) }

#The naughty regex way
input = File.readlines("input.txt", chomp: true).map { |line| line.gsub(" ", "") }
REGEX = /\(((?:\d+|\+|\*)+)\)/

def calculate(line, op)
  while line.include?(op)
    line.gsub!(/(\d+(?:#{Regexp.escape(op)})\d+)/) { |r| eval(r).to_s}
  end
  line
end

res = input.map do |line|
  while line.include?("(")
    line.gsub!(REGEX) { |m| calculate(m, "+") }
    line.gsub!(REGEX) { |m| calculate(m, "*") }
    line.gsub!(/\((\d+)\)/, '\1')
  end
  line = calculate(line, "+")
  line = calculate(line, "*")
  line
end

pp res.map(&:to_i).sum

