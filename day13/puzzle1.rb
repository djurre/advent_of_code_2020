input = File.readlines("input.txt", chomp: true)

min_time = input[0].to_i
schedules = input[1].split(",").filter_map { |x| Integer(x) rescue nil }

pp schedules.map { |time| [time, ((min_time / time) * time) + time - min_time] }.min_by { |i| i[1] }.inject(:*)
