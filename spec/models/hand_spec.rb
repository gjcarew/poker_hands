require 'rails_helper'

RSpec.describe Hand, type: :model do
  it { should belong_to :player }
  it { should belong_to :round }
  it { should have_many :cards }
end
