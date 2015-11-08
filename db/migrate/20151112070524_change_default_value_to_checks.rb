class ChangeDefaultValueToChecks < ActiveRecord::Migration
  def change
    change_column_default(:checks, :box, 1)
  end
end
