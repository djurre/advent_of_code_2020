numbers = File.read("input.txt").split('').map(&:to_i)
moves = 10000000
max = 1000000
numbers += (10..max).to_a
list = {}

max.times { |i| list[numbers[i]] = numbers[i + 1] }
list[numbers.last] = numbers.first
current_cup = numbers.first

moves.times do
  three_cups = [list[current_cup], list[list[current_cup]], list[list[list[current_cup]]]]

  destination_cup = current_cup - 1
  destination_cup = max if destination_cup == 0

  while three_cups.include?(destination_cup)
    destination_cup = destination_cup - 1
    destination_cup = max if destination_cup == 0
  end

  # close the gap
  list[current_cup] = list[three_cups.last]

  # insert the cups
  list[three_cups.last] = list[destination_cup]
  list[destination_cup] = three_cups.first

  # advance
  current_cup = list[current_cup]
end

pp list[1] * list[list[1]]
