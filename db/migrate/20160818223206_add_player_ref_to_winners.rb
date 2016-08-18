class AddPlayerRefToWinners < ActiveRecord::Migration[5.0]
  def change
    add_reference :winners, :player, foreign_key: true
  end
end
