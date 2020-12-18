fields = File.readlines("ranges.txt", chomp: true)
tickets = File.readlines("nearby.txt", chomp: true).map{ |t| t.split(',').map(&:to_i)}
my_ticket = [71,127,181,179,113,109,79,151,97,107,53,193,73,83,191,101,89,149,103,197]

range_list = fields.flat_map do |r|
  ranges = r.match(/(\d+)-(\d+) or (\d+)-(\d+)/).captures
  [(ranges[0].to_i..ranges[1].to_i), (ranges[2].to_i..ranges[3].to_i)]
end

valid_tickets = tickets.select do |ticket|
  ticket.all? do |field|
    range_list.any?{|range| (range === field)}
  end
end


ranges = {}


fields.each do |r|
  vals = r.match(/(.+): (\d+)-(\d+) or (\d+)-(\d+)/).captures
  ranges[vals[0]] = [(vals[1].to_i..vals[2].to_i), (vals[3].to_i..vals[4].to_i)]
end


possible_solutions = {}

my_ticket.count.times do |i|
  possible_solutions[i] = ranges.keys
end

possible_solutions.each do |position, options|
  options.select! do |option|
    range1, range2 = ranges[option]
    field_valid = valid_tickets.all? do |ticket|
      field = ticket[position]
      range1 === field || range2 === field
    end
    field_valid
  end
end

until possible_solutions.values.all? { |v| v.count == 1 } do
  singles = possible_solutions.values.select { |v| v.count == 1 }.flatten
  possible_solutions.each do |pos, options|
    possible_solutions[pos] = options - singles if options.count > 1
  end
end

# pp valid_tickets
pp possible_solutions
indexes =  possible_solutions.select{|k, v| v[0].start_with?("departure")}.keys

pp indexes
# pp ranges