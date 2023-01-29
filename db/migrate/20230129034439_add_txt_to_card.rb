class AddTxtToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :txt, :string
  end
end
