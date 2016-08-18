class BattleSerializer < ActiveModel::Serializer
  attributes :id, :winner_score, :loser_score
end
