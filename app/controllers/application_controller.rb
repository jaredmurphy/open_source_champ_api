class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  skip_before_filter  :verify_authenticity_token
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
    url = "#{root_url}#{player[:login]}?client_id=#{github_id}&client_secret=#{github_secret}"
    response = HTTParty.get(url)
  end

  def generate_winner player_one, player_two
    player_one_score = generate_score player_one
    player_two_score = generate_score player_two

    if player_one_score > player_two_score
        winner = {:player => player_one, :score => player_one_score}
        loser = {:player => player_two, :score => player_two_score}
    elsif player_one_score < player_two_score
        winner = {:player => player_two, :score => player_two_score}
        loser = {:player => player_one, :score => player_one_score}
    end

    {:winner => winner, :loser => loser}
  end

  def generate_score player
    response = hit_github_for_player player
    score = response["public_repos"] + response["public_gists"] + (response["followers"] * 2) + response["following"]
  end

end
