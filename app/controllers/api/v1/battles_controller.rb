class Api::V1::BattlesController < ApplicationController
  before_action :set_battle, only: [:show, :update, :destroy]

  # GET /battles
  def index
    #query = "SELECT * FROM battles, players, winners, losers WHERE (player.id = winner.player_id AND winner.battle_id = battle.id) OR (player.id = loser.player_id AND loser.battle_id = battle.id)"
    #@battles = ActiveRecord::Base.connection.execute(query)
    # @battles = Battle.joins(:winners, :losers)
    # .where("battle.id = winner.battle_id OR battle.id = loser.battle_id")
    # .joins(:player).where("winner.player_id = player.id OR loser.player_id = player.id")
    @winners = Winner.all
    @losers = Loser.all
    @players = Player.all
    @battles = Battle.select("*").joins(:losers)
    #.where("battle.id = loser.battle_id") #OR battle.id = winner.battle_id")
    render json: @battles
  end

  # GET /battles/1
  def show
    render json: @battle
  end

  # POST /battles
  def create
    @battle = Battle.new(battle_params)

    if @battle.save
      render json: @battle, status: :created, location: @battle
    else
      render json: @battle.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /battles/1
  def update
    if @battle.update(battle_params)
      render json: @battle
    else
      render json: @battle.errors, status: :unprocessable_entity
    end
  end

  # DELETE /battles/1
  def destroy
    @battle.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle
      @battle = Battle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_params
      params.require(:battle).permit(:winner_score, :loser_score)
    end
end
