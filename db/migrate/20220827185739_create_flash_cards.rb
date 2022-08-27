class CreateFlashCards < ActiveRecord::Migration[7.0]
  def change
    create_table :flash_cards do |t|
      t.string :question, null: false
      t.string :answer, null: false
      t.integer :deck_id, null: false

      t.timestamps
    end
  end
end
