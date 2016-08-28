class Api::V1::BattlesController < ApplicationController
  #before_action :set_battle, only: [:show, :update, :destroy]

  # GET /battles
  def index
    @battles = Battle.all.with_results
    render json: @battles
  end

  # GET /battles/:id
  def show
    @battle = Battle.find_by(id: params[:id])
    if @battle.nil?
      not_found   
    else 
      render json: @battle
    end
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
    def not_found
      render json: { :error => "Not Found" }, :status => 404
    end

    def set_battle
      @battle = Battle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_params
      params.require(:battle).permit(:winner_score, :loser_score)
    end
end
