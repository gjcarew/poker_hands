require 'rails_helper'

RSpec.describe Card, type: :model do
  it { should belong_to :hand }

  let(:card) { Card.create!(suit: 'diamond', rank: 'queen', value: 12) }

  it 'exists' do
    expect(card).to be_a Card
  end

  it 'has attributes' do 
    expect(card.suit).to eq('diamond')
    expect(card.rank).to eq('queen')
    expect(card.value).to eq(12)
  end
end
