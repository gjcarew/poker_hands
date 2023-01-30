class Card < ApplicationRecord
  belongs_to :hand
  before_save :parse_card

  def parse_card
    self.suit = self.txt[1]
    self.rank = self.txt[0]
    self.value = self.rank.to_i

    self.value = lookup_value[self.rank] if self.value == 0 
  end

  private

  def lookup_value
    { 
      'T' => 10,
      'J' => 11,
      'Q' => 12,
      'K' => 13,
      'A' => 14
    }
  end
end
