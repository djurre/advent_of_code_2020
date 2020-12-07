@input = File.readlines("input.txt")

def find(color)
  bags = @input.filter_map{|l| l.match(/^(.*) bags+ contain.*#{Regexp.quote(color)}/)&.captures }.flatten
  bags + bags.map{|l| find(l)}
end

puts find("shiny gold").flatten.uniq.count
