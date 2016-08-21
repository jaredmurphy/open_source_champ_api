class Battle < ApplicationRecord
  
  has_one :winner
  has_one :loser

  has_one :player, through: :winner
  has_one :player, through: :loser
end
