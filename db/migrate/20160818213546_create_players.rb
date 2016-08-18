class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.integer :github_id
      t.string :login
      t.string :avatar_url
      t.string :blog
      t.string :github_created_at
      t.integer :followers
      t.integer :following
      t.integer :public_repos
      t.integer :public_gists
      t.string :location
      t.string :company

      t.timestamps
    end
  end
end
