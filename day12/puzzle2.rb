input = File.readlines("input.txt", chomp: true).map { |s| s.split(/(\d+)/) }.map { |a, b| [a, b.to_i] }

@degrees = 90
@steps = []
@waypoint = { "N" => 1, "S" => 0, "E" => 10, "W" => 0 }

def turn(direction, degrees)
  (degrees / 90).times do
    if direction == "R"
      @waypoint = { "N" => @waypoint["W"], "S" => @waypoint["E"], "E" => @waypoint["N"], "W" => @waypoint["S"] }
    else
      @waypoint = { "N" => @waypoint["E"], "S" => @waypoint["W"], "E" => @waypoint["S"], "W" => @waypoint["N"] }
    end
  end
end

def forward(steps)
  %w(N E W S).each do |direction|
    @steps << direction * (@waypoint[direction] * steps)
  end
end

def move(direction, steps)
  @waypoint[direction] += steps
end

input.each do |instruction|
  command, value = instruction
  case instruction[0]
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