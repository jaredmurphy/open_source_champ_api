class AddGithubUrlToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :github_url, :string
  end
end
