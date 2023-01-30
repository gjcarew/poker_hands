require 'rails_helper'

RSpec.describe Hand, type: :model do
  it { should belong_to :player }
  it { should belong_to :round }
  it { should have_many :cards }

  describe 'instance methods' do 
    let(:round) { Round.create! }
    let(:player1) { Player.create!(name: 'Player 1') }
    let(:player2) { Player.create!(name: 'Player 2') }
    let(:round1) { Round.create! }

    let(:hand1) { round1.hands.create!(player: player1) }
    let(:hand2) { round1.hands.create!(player: player2) }

    it '#straight?' do
      %w[TD JD QD KD AD].each do |card|
        hand1.cards.create!(txt: card)
      end

      %w[4H 4D 9C 9H 9S].each do |card|
        hand2.cards.create!(txt: card)
      end

      expect(hand1.straight?).to eq(true)
      expect(hand2.straight?).to eq(false)
    end

    it '#flush?' do 
      %w[TD JD QD KD AD].each do |card|
        hand1.cards.create!(txt: card)
      end

      %w[4H 4D 9C 9H 9S].each do |card|
        hand2.cards.create!(txt: card)
      end

      expect(hand1.flush?).to eq(true)
      expect(hand2.flush?).to eq(false)
    end

    describe '#highest_duplicates' do
      it 'returns a hash of count of the values of each hand' do 
        %w[TD JD QD KD AD].each do |card|
          hand1.cards.create!(txt: card)
        end

        %w[4H 4D 9C 9H 9S].each do |card|
          hand2.cards.create!(txt: card)
        end

        expect(hand1.highest_duplicates).to eq(1)
        expect(hand2.highest_duplicates).to eq(3)
      end
    end
  end
end
