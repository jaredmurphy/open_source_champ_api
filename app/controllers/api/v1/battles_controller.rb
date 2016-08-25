class Api::V1::BattlesController < ApplicationController
  before_action :set_battle, only: [:show, :update, :destroy]

  # GET /battles
  def index
    # Company.joins(:price_movements,:goods_movements).where("goods_movement.date = price_movement.date")
    #@battles = Battle.joins(:winner, :loser).where("winners.battle_id = battles.id OR losers.battle_id = battles.id")
    @battles = Battle.joins(:winner)
    byebug
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
