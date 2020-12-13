input = File.readlines("input.txt", chomp: true)
mods = input[1].split(",").filter_map { |x, i| Integer(x) rescue nil }
remainders = input[1].split(",").filter_map.with_index { |x, i| (Integer(x) - i) % Integer(x) rescue nil }

def extended_gcd(a, b)
  last_remainder, remainder = a.abs, b.abs
  x, last_x, y, last_y = 0, 1, 1, 0
  while remainder != 0
    last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
    x, last_x = last_x - quotient * x, x
    y, last_y = last_y - quotient * y, y
  end
  return last_remainder, last_x * (a < 0 ? -1 : 1)
end

def invmod(e, et)
  g, x = extended_gcd(e, et)
  x % et
end

def chinese_remainder(mods, remainders)
  max = mods.inject(:*)
  series = remainders.zip(mods).map { |r, m| (r * max * invmod(max / m, m) / m) }
  series.inject(:+) % max
end

pp chinese_remainder(mods, remainders)