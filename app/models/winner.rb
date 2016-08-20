class Winner < ApplicationRecord
  belongs_to :battle
  belongs_to :player
end
