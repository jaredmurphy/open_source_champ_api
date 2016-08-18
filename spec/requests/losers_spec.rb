require 'rails_helper'

RSpec.describe "Losers", type: :request do
  describe "GET /losers" do
    it "works! (now write some real specs)" do
      get losers_path
      expect(response).to have_http_status(200)
    end
  end
end
