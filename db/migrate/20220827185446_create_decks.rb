class CreateDecks < ActiveRecord::Migration[7.0]
  def change
    create_table :decks do |t|
      t.string :name, null: false
      t.string :label
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
