input = File.readlines("input.txt", chomp: true)

@mem = {}

def apply_mask(address, mask)
  mask.each_char.with_index do |char, index|
    case char
    when "1"
      address[index] = "1"
    when "X"
      address[index] = "X"
    end
  end
  address
end

def write_to_mem(address, value)
  num_floating = address.count("X")
  if num_floating == 0
    @mem[address.to_i(2)] = value
    return
  end

  (0..2 ** num_floating - 1).each do |i|
    sub_mask = "%0#{num_floating}b" % i
    final_address = address
    num_floating.times do |j|
      final_address = final_address.sub("X", sub_mask[j])
    end

    @mem[final_address.to_i(2)] = value
  end
end


input.slice_before { |l| l.include?("mask") }.map do |m|
  mask = m[0].split("mask = ")[1]
  instructions = m[1..-1].map { |i| i.match(/mem\[(\d+)\] = (\d+)/).captures }

  instructions.each do |address, value|
    new_address = apply_mask('%036b' % address, mask)
    write_to_mem(new_address, value)
  end
end


pp @mem.values.sum { |v| v.to_i }