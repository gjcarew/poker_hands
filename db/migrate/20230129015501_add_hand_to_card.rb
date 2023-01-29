class AddHandToCard < ActiveRecord::Migration[5.2]
  def change
    add_reference :cards, :hand, foreign_key: true
  end
end
