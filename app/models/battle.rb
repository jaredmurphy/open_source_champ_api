class Battle < ApplicationRecord
  validates :winner_score, :loser_score, :winner_id, :loser_id, presence: true
  validates :winner_score, :loser_score, :winner_id, :loser_id, numericality: true

  belongs_to :winner,
    class_name: "Player",
    foreign_key: "winner_id"

  belongs_to :loser,
    class_name: "Player",
    foreign_key: "loser_id"

  scope :with_results, -> { includes(:winner, :loser) }
end
