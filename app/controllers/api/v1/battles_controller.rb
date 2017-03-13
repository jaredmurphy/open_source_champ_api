class Api::V1::BattlesController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token, :only => [:create]
  wrap_parameters format: [:json] 
  # GET /battles
  def index
    render json: Battle.all.to_json(include: [:winner, :loser])
  end

  # GET /battles/lists/recent
  def recent
    render json: Battle.order(created_at: :desc)
  end 

  # GET /battles/lists/top
  def top
    render json: Battle.order(winner_score: :desc).limit(10)
  end

  # GET /battles/:id
  def show
    @battle = Battle.find_by(id: params[:id])    
    #@battle = Battle.find_by(id: params[:id]).with_results

    if @battle.nil?
      not_found
    else
      render json: @battle.to_json(include: [:winner, :loser])
    end
  end

  # POST /battles
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
    # Only allow a trusted parameter "white list" through.
    def battle_params
      params.require(:players).permit(:player_one, :player_two)
    end

    # verify json request
    def json_request?
    request.format.json?
  end
end
