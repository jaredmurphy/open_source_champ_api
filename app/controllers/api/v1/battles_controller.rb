class Api::V1::BattlesController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token, :only => [:create]
  wrap_parameters format: [:json] 

  def index
    render json: Battle.all_results
  end

  def recent
    render json: Battle.order(created_at: :desc)
  end 

  def top
    render json: Battle.order(winner_score: :desc).limit(10)
  end

  def show
    @battle = Battle.find_by(id: params[:id])    

    if @battle.nil?
      not_found
    else
      render json: Battle.find_results(params[:id])
    end
  end

  def create
    player_one = Player.find(params[:players][:player_one])
    player_two = Player.find(params[:players][:player_two])

    game = generate_winner player_one, player_two

    battle = Battle.create(
      :winner_score => game[:winner][:score],
      :winner_id => game[:winner][:player][:id],
      :loser_score => game[:loser][:score],
      :loser_id => game[:loser][:player][:id]
    )

    if battle.save
      render json: battle, status: :created
    else
      render json: battle.errors, status: :unprocessable_entity
    end
  end

  private
    def battle_params
      params.require(:players).permit(:player_one, :player_two)
    end
end
