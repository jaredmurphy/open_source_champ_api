class AddBioToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :bio, :string
  end
end
