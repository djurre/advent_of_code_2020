input = File.read("input.txt", chomp: true).split("\n\n").map { |l| l.gsub("\n", " ") }

mandatory = %w[byr: iyr: eyr: hgt: hcl: ecl: pid:]

result = input.count do |line|
  mandatory.all? { |d| line.include?(d) }
end

puts result

# As a oneliner:
puts File.read("input.txt", chomp: true).split("\n\n").count { |line| %w[byr: iyr: eyr: hgt: hcl: ecl: pid:].all? { |d| line.include?(d) } }