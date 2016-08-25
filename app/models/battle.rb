class Battle < ApplicationRecord
  belongs_to :winner,
    class_name: "Player",
    foreign_key: "winner_id"

  belongs_to :loser,
    class_name: "Player",
    foreign_key: "loser_id"

  scope :with_results, -> { includes(:winner, :loser) }
end
