input = File.readlines("input.txt", chomp: true)

def parse_program(input)
  input.map do |line|
    op, val = line.split(" ")
    { op: op, val: val.to_i, exec: false }
  end
end

def run_program(program)
  acc = 0
  pos = 0
  while true do
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
    return acc if pos == program.length
    return nil if program[pos][:exec]
  end
end

res = input.map.with_index do |_, i|
  program = parse_program(input)
  program[i][:op] = program[i][:op].gsub(/.*/, { "jmp" => "nop", "nop" => "jmp", "acc" => "acc" })
  run_program(program)
end

puts res.compact
