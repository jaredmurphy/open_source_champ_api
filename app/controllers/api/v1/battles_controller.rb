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
    player_one = params[:players][:player_one]
    player_two = params[:players][:player_two]


    player_one_exists = Player.where(login: player_one).first_or_create
    player_one_id = player_one_exists[:id]

    player_two_exists = Player.where(login: player_two).first_or_create
    player_two_id = player_two_exists[:id]

    game = generate_winner player_one, player_two
    winner_id = 

    @battle = Battle.create({
      :winner_id => game
    })

    if @battle.save
      render json: @battle, status: :created
    else
      render json: @battle.errors, status: :unprocessable_entity
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
