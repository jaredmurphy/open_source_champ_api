class Player < ApplicationRecord
  has_many :winners
  has_many :losers
end
