input = File.readlines("input.txt", chomp: true).map(&:to_i)

pp ([0] + input.sort + [input.max + 3]).
  sort.
  each_cons(3).
  filter_map { |a, b, c| b if c - a == 2 }.
  slice_when { |prev, curr| curr != prev.next }.to_a.
  map { |group| (0..2 ** group.size).count { |mask| ('%03b' % mask).count("0") <= 2 } }.
  inject(:*)
