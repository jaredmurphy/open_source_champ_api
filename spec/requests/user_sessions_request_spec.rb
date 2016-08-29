require 'spec_helper'

describe "GET '/auth/github/callback'" do
  before(:each) do
    valid_github_login_setup
    get "/auth/github/callback"
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end

  it "Should set user id" do
    expect(session[:api_user_id]).to eq(ApiUser.last.id)
  end

  it "should redirect to root" do
    expect(response).to redirect_to root_path
  end
end

