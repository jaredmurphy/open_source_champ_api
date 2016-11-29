class Api::V1::BattlesController < ApplicationController
  #before_action :set_battle, only: [:show, :update, :destroy]

  #protect_from_forgery
  #skip_before_action :verify_authenticity_token, if: :json_request?
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.include? 'application/json' }
  wrap_parameters format: [:json]

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

    def set_battle
      @battle = Battle.find(params[:id])
    end

    def deserialized_params
      ActionController::Parameters.new(
        ActiveModelSerializers::Deserialization.jsonapi_parse!(params)
      )
    end

    # Only allow a trusted parameter "white list" through.
    def battle_params
      params.require(:players).permit(:player_one, :player_two)
    end
end
