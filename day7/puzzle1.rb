@input = File.readlines("input.txt", chomp: true)

def find(color)
  bags = @input.map{|l| l.match(/^(.*) bags+ contain.*#{Regexp.quote(color)}/)&.captures }.compact.flatten
  bags + bags.map{|l| find(l)}
end

puts find("shiny gold").flatten.uniq.count
