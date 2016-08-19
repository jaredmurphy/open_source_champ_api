class Battle < ApplicationRecord
  belongs_to :winner
  belongs_to :loser
end
