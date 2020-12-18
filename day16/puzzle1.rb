fields = File.readlines("ranges.txt", chomp: true)
tickets = File.readlines("nearby.txt", chomp: true).map{ |t| t.split(',').map(&:to_i)}

range_list = fields.flat_map do |r|
  ranges = r.match(/(\d+)-(\d+) or (\d+)-(\d+)/).captures
  [(ranges[0].to_i..ranges[1].to_i), (ranges[2].to_i..ranges[3].to_i)]
end

res = tickets.map do |ticket|
  ticket.reject do |field|
    range_list.any?{|range| range === field}
  end
end

pp res.flatten.sum
