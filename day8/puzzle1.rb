input = File.readlines("input.txt", chomp: true)

acc = 0
pos = 0
finished = false

program = input.map do |line|
  op, val = line.split(" ")
  {op: op, val: val.to_i, exec: false }
end

until finished do
  command = program[pos]
  command[:exec] = true

  case command[:op]
  when "acc"
    acc += command[:val]
    pos += 1
  when "jmp"
    pos += command[:val]
  when "nop"
    pos += 1
  else
    raise "unrecognized command"
  end
  finished = true if program[pos][:exec]
end

puts acc