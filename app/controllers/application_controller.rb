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

  def generate_score player
    byebug
  end

end
