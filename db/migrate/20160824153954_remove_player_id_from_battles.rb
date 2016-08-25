class RemovePlayerIdFromBattles < ActiveRecord::Migration[5.0]
  def change
    remove_reference :battles, :player, foreign_key: true
  end
end
