class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.text :name
      t.boolean :current

      t.timestamps null: false
    end
  end
end
