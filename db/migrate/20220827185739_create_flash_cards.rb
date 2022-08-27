class CreateFlashCards < ActiveRecord::Migration[7.0]
  def change
    create_table :flash_cards do |t|
      t.string :question
      t.string :answer
      t.integer :deck_id

      t.timestamps
    end
  end
end
