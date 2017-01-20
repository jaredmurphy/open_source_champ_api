class Player < ApplicationRecord
  validates :login, presence: true
  validates :avatar_url, presence: true
  validates :login, :uniqueness => true

  has_many :battles
end
