input = File.readlines("input.txt", chomp: true).map { |line| line.split(",").map { |i| i.to_i } }.flatten

pp input

numbers = {}
last_spoken = input.last

2020.times do |turn|
  if turn < input.count
    last_spoken = input[turn]
  elsif numbers[last_spoken].count < 2
    last_spoken = 0
  else
    a,b = numbers[last_spoken].sort[-2..-1]
    last_spoken = b-a
  end

  numbers[last_spoken] = (numbers[last_spoken] || []) << turn
end

pp last_spoken