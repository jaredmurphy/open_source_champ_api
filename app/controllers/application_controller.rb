class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :current_user, :generate_score

  private

  def github_client
    @github_client ||= Github::Client.new
  end

  def parse_request
   @json = JSON.parse(request.body.read)
  end

  def not_found
    render json: { :error => "Not Found" }, :status => 404
  end

  def current_user
    return unless session[:api_user_id]
    @current_user ||= ApiUser.find(session[:api_user_id])
  end

  def generate_winner(player_one, player_two)
    players = [
      {
        player: player_one,
        score: generate_score(player_one)
      },
      {
        player: player_two,
        score: generate_score(player_two)
      }
    ]

    players.sort_by{ |p| p[:score] }

    { winner: players.first, loser: players.second }
  end

  def generate_score(player)
    response = github_client.player(player)

    response["public_repos"]
      + response["public_gists"]
      + (response["followers"] * 2)
      + response["following"]
  end
end
