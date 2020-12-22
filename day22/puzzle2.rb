require 'set'
deck1, deck2 = File.readlines("input.txt", chomp: true).reject(&:empty?).slice_before { |line| line.include?("Player") }.map { |nums| nums.drop(1) }.map { |x| x.map(&:to_i) }

def play_game(deck1, deck2)
  rounds = Set.new

  until deck1.empty? || deck2.empty? do
    return :player1 if rounds.include?([deck1, deck2])

    rounds.add([deck1.dup, deck2.dup])
    c1 = deck1.shift
    c2 = deck2.shift

    winner = if deck1.count >= c1 && deck2.count >= c2
               play_game(deck1[0..(c1 - 1)], deck2[0..(c2 - 1)])
             else
               c1 > c2 ? :player1 : :player2
             end

    winner == :player1 ? deck1.concat([c1, c2]) : deck2.concat([c2, c1])
  end

  deck1.empty? ? :player2 : :player1
end

play_game(deck1, deck2)
cards = deck1 + deck2
pp cards.reverse.zip((1..cards.count).to_a).map { |comb| comb.inject(:*) }.sum



