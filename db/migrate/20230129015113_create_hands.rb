class CreateHands < ActiveRecord::Migration[5.2]
  def change
    create_table :hands do |t|
      t.references :player, foreign_key: true
      t.references :round, foreign_key: true

      t.timestamps
    end
  end
end
