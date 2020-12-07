@input = File.readlines("input.txt", chomp: true)

def find(color)
  @input.
    map { |l| l.match(/^#{Regexp.quote(color)} bags contain (.*)/)&.captures }.
    compact.
    flatten[0].
    split(",").
    map { |l| l.gsub(/bags?\.?/, '').strip }.map { |r| r.match(/^(\d+) (.*)/)&.captures }.
    compact.map { |number, color| number.to_i * (find(color) + 1) }.
    sum
end


puts find("shiny gold")
