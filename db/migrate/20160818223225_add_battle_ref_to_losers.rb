class AddBattleRefToLosers < ActiveRecord::Migration[5.0]
  def change
    add_reference :losers, :battle, foreign_key: true
  end
end
