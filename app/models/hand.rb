class Hand < ApplicationRecord
  has_many :cards
  belongs_to :player
  belongs_to :round

  def straight?
    cards.order(:value).each_cons(2).all? {|a, b| b.value == a.value + 1 }
  end

  def flush?
    cards[1..-1].all? { |card| card.suit == cards[0].suit }
  end

  def duplicate_vals
    cards.pluck(:value).tally
  end

  def rank
    if flush?
      return [9, cards.maximum(:value)] if straight?
      return [6] + cards.order('cards.value DESC').pluck(:value)
    end

    duplicates = duplicate_vals
    case duplicates.values.max
    when 4
      [8, duplicates.key(4), duplicates.key(1)]
    when 3
      if duplicates.length == 2
        [7, duplicates.key(3), duplicates.key(2)]
      else
        [4, duplicates.key(3)] +
          duplicates.select { |_k, v| v == 1 }.keys.sort.reverse
      end
    when 2
      if duplicates.length == 3
        [3] +
          duplicates.select { |_k, v| v == 2 }.keys.sort.reverse +
          [duplicates.key(1)]
      else
        [2] + [duplicates.key(2)] +
          duplicates.select { |_k, v| v == 1 }.keys.sort.reverse
      end
    when 1
      if straight?
        [5, cards.maximum(:value)]
      else
        [1] + cards.order('cards.value DESC').pluck(:value)
      end
    end
  end
end
