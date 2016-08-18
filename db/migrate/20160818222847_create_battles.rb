class CreateBattles < ActiveRecord::Migration[5.0]
  def change
    create_table :battles do |t|
      t.integer :winner_score
      t.integer :loser_score

      t.timestamps
    end
  end
end
