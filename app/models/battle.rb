class Battle < ApplicationRecord
  validates :winner_score, :loser_score, :winner_id, :loser_id, presence: true
  validates :winner_score, :loser_score, :winner_id, :loser_id, numericality: true

  belongs_to :winner,
    class_name: "Player",
    foreign_key: "winner_id"

  belongs_to :loser,
    class_name: "Player",
    foreign_key: "loser_id"

  scope :all_results, -> { all.to_json(include: [:winner, :loser]) }
  scope :find_results, -> (id) { find(id).to_json(include: [:winner, :loser]) }

end
