class RemoveWinnersAndLosers < ActiveRecord::Migration[5.0]
  def change
    drop_table :losers
    drop_table :winners
  end
end
