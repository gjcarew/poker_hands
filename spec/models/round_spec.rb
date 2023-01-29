require 'rails_helper'

RSpec.describe Round, type: :model do
  it { should have_many :hands }
  it { should have_many(:players).through(:hands) }
end
