require "support/factory_girl"
require "rails_helper"

describe "Battles API" do
  let(:winner) { Player.create(login: "player1") }
  let(:loser) { Player.create(login: "player1") }

  before(:each) do
    Battle.create(
      winner_score: 10,
      loser_score: 1,
      winner: winner,
      loser: loser
    )
  end

  describe "GET /battles" do
    it "returns a 200 OK" do
      get "/api/v1/battles"
      expect(response).to be_success
    end
  end

  describe "GET /battles/:id" do
    context "when the id is valid" do
      it "returns a 200 OK" do
        battle = Battle.first

        get "/api/v1/battles/#{battle.id}"
        expect(response).to be_success
      end
    end

    context "when the id is invalid" do
      # @TODO
      xit "returns a 404 Not Found" do
        get "/api/v1/battles/9000"
        expect(response.status).to eq 404
      end
    end
  end
end
