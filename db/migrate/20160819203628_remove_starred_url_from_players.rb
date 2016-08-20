class RemoveStarredUrlFromPlayers < ActiveRecord::Migration[5.0]
  def change
    remove_column :players, :starred_url, :string
  end
end
