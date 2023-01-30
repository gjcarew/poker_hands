class Round < ApplicationRecord
  has_many :hands
  has_many :players, through: :hands

  def find_winner
    ranked_hands = hands.map(&:rank)
    i = 0
    loop do
      update(winner: 1) if ranked_hands[0][i] > ranked_hands[1][i]
      update(winner: 2) if ranked_hands[0][i] < ranked_hands[1][i]
      break unless winner.nil?

      i += 1
    end
  end
end
