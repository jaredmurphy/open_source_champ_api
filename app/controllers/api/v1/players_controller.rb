class Api::V1::PlayersController < ApplicationController
  skip_before_action :verify_authenticity_token
  wrap_parameters format: [:json]

  def index
    render json: Player.all
  end

  def show
    player = Player.find_by(id: params[:id])
    if player.nil?
      not_found
    else
      render json: player
    end
  end

  def search
    player= Player.find_by(:login => params[:login])
    if player
      render json: player
    else
      response = github_client.player({login: params[:login]})
      if response["message"] == "Not Found"
        not_found
      else
        create_player(response)
        new_player = Player.find_by :login => response["login"]
        render json: new_player, status: :created
      end
    end
  end

  private
    def create_player(response)
      Player.create(
          :login => response["login"],
          :avatar_url => response["avatar_url"],
          :blog => response["blog"],
          :github_created_at => response["created_at"],
          :followers => response["followers"],
          :following => response["following"],
          :public_repos => response["public_repos"],
          :public_gists => response["public_gists"],
          :location => response["location"],
          :company => response["company"],
          :kind => response["type"],
          :github_id => response["id"]
        )
    end
end
