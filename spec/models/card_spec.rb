require 'rails_helper'

RSpec.describe Card, type: :model do
  it { should belong_to :hand }

  let(:player) { Player.create!(name: 'Evan')}
  let(:round) { Round.create! }
  let(:hand) { player.hands.create!(round_id: round.id)}
  let(:card) { hand.cards.create!(txt: 'QD') }

  it 'exists' do
    expect(card).to be_a Card
  end

  it 'has attributes' do 
    expect(card.suit).to eq('D')
    expect(card.rank).to eq('Q')
    expect(card.value).to eq(12)
  end
end
