class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :github_id, :login, :avatar_url, :blog, :github_created_at, :followers, :following, :public_repos, :public_gists, :location, :company
  belongs_to :battle
end
