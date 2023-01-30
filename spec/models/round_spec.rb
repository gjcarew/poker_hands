require 'rails_helper'

RSpec.describe Round, type: :model do
  it { should have_many :hands }
  it { should have_many(:players).through(:hands) }

  describe 'instance methods' do
    let(:round) { Round.create! }
    let(:player1) { Player.create!(name: 'Player 1') }
    let(:player2) { Player.create!(name: 'Player 2') }
    let(:round1) { Round.create! }

    let(:hand1) { round1.hands.create!(player: player1) }
    let(:hand2) { round1.hands.create!(player: player2) }
    it '#find_winner' do 
      %w[TD JD QD KD AD].each do |card|
        hand1.cards.create!(txt: card)
      end

      %w[4H 4D 9C 9H 9S].each do |card|
        hand2.cards.create!(txt: card)
      end

      expect(round1.winner).to eq(nil)
      round1.find_winner
      expect(round1.winner).to eq(1)
    end
  end
end
