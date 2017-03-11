class Player < ApplicationRecord
  validates :login, presence: true
  validates :avatar_url, presence: true
  validates :login, :uniqueness => true

  has_many :battles
  has_many :wins, -> { where(winner_id: 1) },
    class_name: "Battle"

end
