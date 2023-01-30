require 'rails_helper'

RSpec.describe Hand, type: :model do
  it { should belong_to :player }
  it { should belong_to :round }
  it { should have_many :cards }

  describe 'instance methods' do 
    let(:round) { Round.create! }
    let(:player1) { Player.create!(name: 'Player 1') }
    let(:player2) { Player.create!(name: 'Player 2') }
    let(:player3) { Player.create!(name: 'Player 2') }
    let(:round1) { Round.create! }

    let(:hand1) { round1.hands.create!(player: player1) }
    let(:hand2) { round1.hands.create!(player: player2) }
    let(:hand3) { round1.hands.create!(player: player3) }

    before :each do
      %w[TD JD QD KD AD].each do |card|
        hand1.cards.create!(txt: card)
      end

      %w[4H 4D 9C 9H 9S].each do |card|
        hand2.cards.create!(txt: card)
      end
    end

    it '#straight?' do
      expect(hand1.straight?).to eq(true)
      expect(hand2.straight?).to eq(false)
    end

    it '#flush?' do 
      expect(hand1.flush?).to eq(true)
      expect(hand2.flush?).to eq(false)
    end

    describe '#duplicate_vals' do
      it 'returns a hash of count of the values of each hand' do 
        hand1_tally = {
          10 => 1,
          11 => 1,
          12 => 1,
          13 => 1,
          14 => 1
        }

        hand2_tally = {
          4 => 2,
          9 => 3
        }

        expect(hand1.duplicate_vals).to eq(hand1_tally)
        expect(hand2.duplicate_vals).to eq(hand2_tally)
      end
    end

    describe '#rank' do 
      it 'Ranks a straight flush' do
        expect(hand1.rank).to eq([9, 14])
      end

      it 'Ranks four of a kind' do
        %w[4H 4D 4C 9H 4S].each do |card|
          hand3.cards.create!(txt: card)
        end
        expect(hand3.rank).to eq([8, 4, 9])
      end

      it 'Ranks a full house' do
        expect(hand2.rank).to eq([7, 9, 4])
      end

      it 'ranks a flush' do 
        %w[4H 2H 7H 9H KH].each do |card|
          hand3.cards.create!(txt: card)
        end

        expect(hand3.rank).to eq([6, 13, 9, 7, 4, 2])
      end

      it 'ranks a straight' do 
        %w[4S 5H 7H 6H 8H].each do |card|
          hand3.cards.create!(txt: card)
        end

        expect(hand3.rank).to eq([5, 8])
      end

      it 'ranks three of a kind' do 
        %w[5S 5H 5D 6H 8H].each do |card|
          hand3.cards.create!(txt: card)
        end

        expect(hand3.rank).to eq([4, 5, 8, 6])
      end

      it 'ranks two pairs' do
        %w[5S 5H 6D 6H 8H].each do |card|
          hand3.cards.create!(txt: card)
        end

        expect(hand3.rank).to eq([3, 6, 5, 8])
      end

      it 'ranks one pair' do 
        %w[5S 5H 7D 6H 8H].each do |card|
          hand3.cards.create!(txt: card)
        end

        expect(hand3.rank).to eq([2, 5, 8, 7, 6])
      end

      it 'ranks a high card hand' do 
        %w[5S 2H 7D 6H 8H].each do |card|
          hand3.cards.create!(txt: card)
        end

        expect(hand3.rank).to eq([1, 8, 7, 6, 5, 2])
      end

    end
  end

end
