class AddWinnerAndLoserToBattle < ActiveRecord::Migration[5.0]
  def change
    add_reference :battles, :winner
    add_reference :battles, :loser
  end
end
