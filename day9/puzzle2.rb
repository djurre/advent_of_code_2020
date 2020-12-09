input = File.readlines("input.txt", chomp: true).map(&:to_i)

val = 1504371145

(0..input.size).each do |i|
  (0..input.size).each do |j|
    if input[(i..j)].sum == val
      puts input[(i..j)].max + input[(i..j)].min
      return
    end
  end
end