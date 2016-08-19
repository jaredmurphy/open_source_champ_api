class Winner < ApplicationRecord
  has_one :battle
  has_one :player
end
