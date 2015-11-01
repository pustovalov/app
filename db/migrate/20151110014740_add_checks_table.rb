class AddChecksTable < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.integer :times_reviewed, null: false, default: 0
      t.integer :losing_streak, null: false, default: 0

      t.timestamps null: false
    end
  end
end
