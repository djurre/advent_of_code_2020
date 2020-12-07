@input = File.readlines("input.txt", chomp: true)

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
