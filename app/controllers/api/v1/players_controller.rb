class Api::V1::PlayersController < ApplicationController
  #before_action :set_player, only: [:show, :update, :destroy]

  # GET /players
  def index
    @players = Player.all

    render json: @players
  end

  # GET /players/:id
  def show
    @player = Player.find_by(id: params[:id])

    if @player.nil?
      not_found   
    else 
      render json: @player
    end
  end

  # POST /players
  def create
    @player = Player.new(player_params)

    if @player.save
      render json: @player, status: :created, location: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /players/1
  def update
    if @player.update(player_params)
      render json: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end


    # Only allow a trusted parameter "white list" through.
    def player_params
      params.require(:player).permit(:github_id, :login, :avatar_url, :blog, :github_created_at, :followers, :following, :public_repos, :public_gists, :location, :company)
    end
end
