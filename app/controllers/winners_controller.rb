class WinnersController < ApplicationController
  before_action :set_winner, only: [:show, :update, :destroy]

  # GET /winners
  def index
    @winners = Winner.all

    render json: @winners
  end

  # GET /winners/1
  def show
    render json: @winner
  end

  # POST /winners
  def create
    @winner = Winner.new(winner_params)

    if @winner.save
      render json: @winner, status: :created, location: @winner
    else
      render json: @winner.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /winners/1
  def update
    if @winner.update(winner_params)
      render json: @winner
    else
      render json: @winner.errors, status: :unprocessable_entity
    end
  end

  # DELETE /winners/1
  def destroy
    @winner.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_winner
      @winner = Winner.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def winner_params
      params.fetch(:winner, {})
    end
end
