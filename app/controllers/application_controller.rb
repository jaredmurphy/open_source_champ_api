class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :current_user, :generate_score

  private

  def parse_request
   @json = JSON.parse(request.body.read)
  end

  def not_found
    render json: { :error => "Not Found" }, :status => 404
  end

  def current_user
    @current_user ||= ApiUser.find(session[:api_user_id]) if session[:api_user_id]
  end

  def hit_github_for_player player
    root_url = "https://api.github.com/users/"
    github_id = ENV['GITHUB_ID']
    github_secret = ENV['GITHUB_SECRET']
    url = "#{root_url}#{player}?client_id=#{github_id}&client_secret=#{github_secret}"
    response = HTTParty.get(url)
  end

  def generate_winner player_one, player_two
    player_one_score = generate_score player_one
    player_two_score = generate_score player_two

    player_one_info = {:login => player_one, :score => player_one_score}
    player_two_info = {:login => player_two, :score => player_two_score}

    winner = player_one_info[:score] > player_two_info[:score] ? player_one_info : player_two_info
    loser = player_one_info[:score] < player_two_info[:score] ? player_one_info : player_two_info
    game = {:winner => winner, :loser => loser}
  end

  def generate_score player
    response = hit_github_for_player player
    score = response["public_repos"] + response["public_gists"] + response["followers"] + response["following"]
  end

end
