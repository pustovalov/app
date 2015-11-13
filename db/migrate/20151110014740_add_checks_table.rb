class AddChecksTable < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.integer :times_reviewed, null: false, default: 0
      t.integer :losing_streak, null: false, default: 0
      t.integer :box, :integer, null: false, default: 1
      t.integer :card_id, :integer

      t.timestamps null: false
    end
  end
end
