class Player < ApplicationRecord
  belongs_to :winner
  belongs_to :loser
end
