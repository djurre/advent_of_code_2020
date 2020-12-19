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
      if r == "$8" || r == "$11"
        value = value.gsub(/#{Regexp.escape(r)}(\D|$|\|)/, "xxx" + '\1')
      else
        value = value.gsub(/#{Regexp.escape(r)}(\D|$|\|)/, rules[r] + '\1')
      end
    end
    value
  end
end

res["$8"] = "($42|$42$8)"
res["$11"] = "($42$31|$42$11$31)"
old_res_value = []

while old_res_value != res.values do
  old_res_value = res.values
  res = apply_rules(res)
end

res["$8"] = "#{res["$8"].delete("xxx")}+"
reg = (1...6).map { |i| "#{res["$42"] * i}#{res["$31"] * i}"}.join("|")
res["$11"] = "(#{reg})"
res["$0"] = "#{res["$8"]}#{res["$11"]}"

rule0 = res["$0"]
answer = texts.select { |text| text.match(/^#{rule0}$/) }

pp answer.count