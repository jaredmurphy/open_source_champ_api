class Player < ApplicationRecord
  # belongs_to :winner
  # belongs_to :loser
  has_many :winners
  has_many :losers
end
