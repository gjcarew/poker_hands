class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :suit
      t.string :rank
      t.integer :value

      t.timestamps
    end
  end
end
