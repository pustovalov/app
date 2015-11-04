class AddBoxToChecks < ActiveRecord::Migration
  def change
    add_column :checks, :box, :integer, null: false, default: 0
  end
end
