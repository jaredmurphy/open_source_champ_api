class AddBattleIdToWinners < ActiveRecord::Migration[5.0]
  def change
    add_reference :winners, :battle, foreign_key: true
  end
end
