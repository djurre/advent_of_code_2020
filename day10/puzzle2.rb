input = File.readlines("input.txt", chomp: true).map(&:to_i)

# My original way
pp ([0] + input.sort + [input.max + 3]).
  sort.
  each_cons(3).
  filter_map { |a, b, c| b if c - a == 2 }.
  slice_when { |prev, curr| curr != prev.next }.to_a.
  map { |group| (0..2 ** group.size).count { |mask| ('%03b' % mask).count("0") <= 2 } }.
  inject(:*)


# The graph way
cache = {0 => 1}
cache.default = 0
(input + [input.max + 3]).sort.each do |num|
  cache[num] = (1..3).sum { |t| cache[num - t]  }
end

pp cache[input.max]