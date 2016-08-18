class AddLoserIdToBattles < ActiveRecord::Migration[5.0]
  def change
    add_reference :battles, :player, foreign_key: true
  end
end
