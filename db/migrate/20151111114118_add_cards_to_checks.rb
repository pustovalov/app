class AddCardsToChecks < ActiveRecord::Migration
  def change
    add_column :checks, :card_id, :integer
  end
end
