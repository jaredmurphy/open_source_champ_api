class AddPlayerIdToLosers < ActiveRecord::Migration[5.0]
  def change
    add_reference :losers, :player, foreign_key: true
  end
end
