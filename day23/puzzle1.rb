numbers = File.read("input.txt").split('').map(&:to_i)

moves = 100
max = numbers.max

moves.times do
  current_cup = numbers.first
  three_cups = numbers.slice!(1, 3)

  destination_cup = current_cup - 1
  destination_cup = max if destination_cup == 0

  while three_cups.include?(destination_cup)
    destination_cup = destination_cup - 1
    destination_cup = max if destination_cup == 0
  end

  destination_position = numbers.find_index(destination_cup)
  numbers = numbers[0..destination_position] + three_cups + numbers[destination_position + 1..]
  numbers.rotate!(1)
end

pp numbers.rotate!(numbers.find_index(1))[1..].join
