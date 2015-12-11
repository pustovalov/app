class SuperMemo < ActiveRecord::Migration
  def change
    remove_column :checks, :losing_streak
    remove_column :checks, :box
    add_column :cards, :complexity, :float, null: false, default: 2.5
  end
end
