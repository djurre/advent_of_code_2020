input = File.readlines("input.txt", chomp: true).map { |line| line.gsub(" ", "") }

result = input.map do |line|
  until line.match(/^\d+$/)
    pair = line.match(/(\d+(?:\+|\*)\d+)/).captures[0]
    line = line.sub(pair, eval(pair).to_s).gsub(/\((\d+)\)/, '\1')
  end
  line
end

pp result.map(&:to_i).sum
