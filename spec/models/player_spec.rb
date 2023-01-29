require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should have_many :hands }
  it { should have_many(:rounds).through(:hands) }
end
