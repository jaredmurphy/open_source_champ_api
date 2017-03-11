class Player < ApplicationRecord
  validates :login, presence: true
  validates :avatar_url, presence: true
  validates :login, :uniqueness => true

  has_many :battles

  scope: top_10, -> { 
    select("players.*, count(battles.winner_id) AS winners_count").
    joins(:battles).
    group("players.id").
    order("winners_count DESC").
    limit(10)
 }

end
