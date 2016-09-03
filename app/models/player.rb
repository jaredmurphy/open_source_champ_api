class Player < ApplicationRecord
  validates :login, presence: true
  # belongs_to :winner
  # belongs_to :loser
  #has_many :winners
  #has_many :losers
end
