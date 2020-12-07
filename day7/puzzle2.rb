@input = File.readlines("input.txt")

def find(color)
  @input.
    filter_map { |l| l.match(/^#{Regexp.quote(color)} bags contain (.*)/)&.captures }.flatten.
    flat_map { |a| a.split(",") }.
    map { |l| l.gsub(/bags?\.?/, '').strip }.
    filter_map { |r| r.match(/^(\d+) (.*)/)&.captures }.
    map { |number, color| number.to_i * (find(color) + 1) }.
    sum
end

puts find("shiny gold")

# As a one-liner:
puts (process = lambda { |color| File.readlines("input.txt").filter_map { |l| l.match(/^#{Regexp.quote(color)} bags contain (.*)/)&.captures }.flatten.flat_map { |a| a.split(",") }.map { |l| l.gsub(/bags?\.?/, '').strip }.filter_map { |r| r.match(/^(\d+) (.*)/)&.captures }.map { |number, color| number.to_i * (process.call(color) + 1) }.sum }).call("shiny gold")