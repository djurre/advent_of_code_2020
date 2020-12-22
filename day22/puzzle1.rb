player1, player2 = File.readlines("input.txt", chomp: true).reject(&:empty?).slice_before { |line| line.include?("Player") }.map { |nums| nums.drop(1) }.map { |x| x.map(&:to_i) }

until player1.empty? || player2.empty?
  p1_card = player1.shift
  p2_card = player2.shift
  if p1_card > p2_card
    player1 += [p1_card, p2_card]
  else
    player2 += [p2_card, p1_card]
  end
end

cards = player1 + player2
pp cards.reverse.zip((1..cards.count).to_a).map { |comb| comb.inject(:*) }.sum