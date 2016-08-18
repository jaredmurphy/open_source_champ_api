class LosersController < ApplicationController
  before_action :set_loser, only: [:show, :update, :destroy]

  # GET /losers
  def index
    @losers = Loser.all

    render json: @losers
  end

  # GET /losers/1
  def show
    render json: @loser
  end

  # POST /losers
  def create
    @loser = Loser.new(loser_params)

    if @loser.save
      render json: @loser, status: :created, location: @loser
    else
      render json: @loser.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /losers/1
  def update
    if @loser.update(loser_params)
      render json: @loser
    else
      render json: @loser.errors, status: :unprocessable_entity
    end
  end

  # DELETE /losers/1
  def destroy
    @loser.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loser
      @loser = Loser.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def loser_params
      params.fetch(:loser, {})
    end
end
