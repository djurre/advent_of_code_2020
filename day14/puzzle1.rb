input = File.readlines("input.txt", chomp: true)

mem = {}

input.slice_before { |l| l.include?("mask") }.map do |m|
  mask = m[0].split("mask = ")[1]
  instructions = m[1..-1].map { |i| i.match(/mem\[(\d+)\] = (\d+)/).captures }

  instructions.each do |address, value|
    value_string = '%036b' % value
    mask.each_char.with_index { |char, index| value_string[index] = char if %w[0 1].include?(char) }
    mem[address] = value_string.to_i(2)
  end
end

pp mem.values.sum