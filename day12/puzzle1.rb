input = File.readlines("input.txt", chomp: true).map { |s| s.split(/(\d+)/) }.map { |a, b| [a, b.to_i] }

@headings = { 0 => "N", 90 => "E", 180 => "S", 270 => "W", }
@degrees = 90
@steps = []

def turn(direction, degrees)
  direction == "R" ?  @degrees += degrees : @degrees -= degrees
end

def forward(steps)
  @steps << @headings[@degrees % 360] * steps
end

def move(direction, steps)
  @steps << direction * steps
end

input.each do |instruction|
  command, value = instruction
  case command
  when "N", "S", "E", "W"
    move(command, value)
  when "L", "R"
    turn(command, value)
  when "F"
    forward(value)
  end
end

@steps = @steps.flatten.join
pp (@steps.count("N") - @steps.count("S")).abs + (@steps.count("W") - @steps.count("E")).abs