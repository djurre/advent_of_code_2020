input = File.read("input.txt", chomp: true).gsub("\"", "").split("\n\n")
rules = input[0].split("\n")
texts = input[1].split("\n")

res = rules.map { |rule| rule.split(":") }.to_h
res = res.transform_values { |v| v.gsub(/\s(\d+)/, '$\1').gsub(" ", "") }
res = res.transform_values { |v| v.include?("|") ? "(#{v})" : v }
res = res.transform_keys { |key| "$#{key}" }

def apply_rules(rules)
  rules.transform_values do |value|
    value.scan(/(\$\d+)/).flatten.each do |r|
      value = value.gsub(/#{Regexp.escape(r)}(\D|$|\|)/, rules[r] + '\1')
    end
    value
  end
end

while res.values.any? { |v| v.include?("$") } do
  res = apply_rules(res)
end

rule0 = res["$0"]
answer = texts.count { |text| text.match(/^#{rule0}$/) }

pp answer