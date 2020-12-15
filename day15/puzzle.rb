@input = File.readlines("input.txt", chomp: true).map { |line| line.split(",").map { |i| i.to_i } }.flatten

def calculate(n)
  numbers = []
  last_numbers = []
  last_spoken = nil

  n.times do |turn|
    if turn < @input.count
      last_spoken = @input[turn]
      numbers[last_spoken] = turn
      next
    end

    if last_numbers[last_spoken].nil?
      last_spoken = 0
    else
      last_spoken = turn - last_numbers[last_spoken] - 1
    end

    last_numbers[last_spoken] = numbers[last_spoken]
    numbers[last_spoken] = turn
  end

  pp last_spoken

end

calculate(2020)
calculate(30000000)