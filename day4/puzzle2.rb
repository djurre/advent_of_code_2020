input = File.read("input.txt").split("\n\n").map{|l| l.split(/\n|\s/)}

conditions = [/^pid:\d{9}$/, /^byr:19[2-9]\d|200[0-2]$/, /^iyr:201[0-9]|2020$/, /^eyr:202[0-9]|2030$/, /^hcl:#[\da-f]{6}$/, /^ecl:(amb|blu|brn|gry|grn|hzl|oth)$/, /^hgt:((1[5-8]\d|19[0-3])cm|(59|6\d|7[0-6])in)$/ ]

result = input.count do |line|
  conditions.all? { |c| line.any?{|l| l.match(c)}}
end

puts result

# As a oneliner:
puts File.read("input.txt").split("\n\n").map{|l| l.split(/\n|\s/)}.count { |line| [/^pid:\d{9}$/, /^byr:19[2-9]\d|200[0-2]$/, /^iyr:201[0-9]|2020$/, /^eyr:202[0-9]|2030$/, /^hcl:#[\da-f]{6}$/, /^ecl:(amb|blu|brn|gry|grn|hzl|oth)$/, /^hgt:((1[5-8]\d|19[0-3])cm|(59|6\d|7[0-6])in)$/ ].all? { |c| line.any?{|l| l.match(c)}}}
