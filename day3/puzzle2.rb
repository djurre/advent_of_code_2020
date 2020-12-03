@input = File.readlines("input.txt", chomp: true)
@x_length = @input.first.size

def calculate(step_x, step_y)
  @input.each_slice(step_y).with_index.map do |lines, index|
    lines.first[(index * step_x) % @x_length]
  end.count('#')
end

steps = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
puts steps.map { |step| calculate(step[0], step[1]) }.inject(:*)