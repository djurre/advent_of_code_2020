list = File.readlines("input.txt", chomp: true).map do |line|
  ingredients, allergens = line.match(/(.*) \(contains (.*)\)/).captures
  ingredients = ingredients.split(" ")
  allergens = allergens.split(", ")
  [ingredients, allergens]
end

result = Hash.new([])
list.each do |ingredients, allergens|
  allergens.each { |allergen| result[allergen] += [ingredients] }
end

all_ingredients = list.map { |i| i[0] }
reduced = result.transform_values { |l| l.inject(:&) }
non_allergens = all_ingredients.flatten.uniq - reduced.values.flatten.uniq

# Answer part 1
pp all_ingredients.flatten.count { |f| non_allergens.include?(f) }


answer = {}
until reduced.values.all? { |value| value.count == 1 }
  filter = reduced.select { |_, ingredients| ingredients.count == 1 }
  answer.merge!(filter)
  reduced.delete(filter.keys[0])
  reduced.transform_values! { |v| v - filter.values.flatten }
end

# Answer part 2
pp answer.merge(reduced).sort.map { |_, v| v }.flatten.join(",")
