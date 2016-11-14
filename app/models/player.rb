class Player < ApplicationRecord
  validates :login, presence: true
  validates :avatar_url, presence: true
  validates :login, :uniqueness => true
  # belongs_to :winner
  # belongs_to :loser
  #has_many :winners
  #has_many :losers
end
