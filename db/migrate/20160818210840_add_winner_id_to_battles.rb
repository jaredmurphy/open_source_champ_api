class AddWinnerIdToBattles < ActiveRecord::Migration[5.0]
  def change
    add_reference :battles, :winner, foreign_key: true
  end
end
