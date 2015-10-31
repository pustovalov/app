class AddChecksTable < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.integer :times_reviewed
      t.integer :losing_streak

      t.timestamps null: false
    end
  end
end
