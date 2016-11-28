require "support/factory_girl"
require "rails_helper"

describe "Battles API" do
  before(:each) do
    @player_one = Player.create(login: "johnrbell", avatar_url: "some_img.jpg")
    @player_two = Player.create(login: "gittheking", avatar_url: "some_img.jpg")

    @battle = Battle.create(
      winner_score: 10,
      loser_score: 1,
      winner_id: @player_one.id,
      loser_id: @player_two.id
    )
  end

  describe "GET /battles" do
    it "returns a 200 OK" do
      get "/api/v1/battles"
      expect(response).to be_success
    end

    it "responds with battle data" do
     get "/api/v1/battles"
     data = JSON.parse(response.body)

     expect(data).to_not be_empty

     data.each do |battle|
       expect(battle.keys).to contain_exactly("id", "winner_score", "loser_score", "created_at", "updated_at", "winner_id", "loser_id")
     end
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
      it "returns a 404 status" do
        get "/api/v1/battles/9999999999999"
        expect(response.status).to eq 404
      end

      it "responds with message of Not Found" do
        get "/api/v1/battles/99999999999999"
        message = JSON.parse(response.body)["error"]
        expect(message).to eq "Not Found"
      end
    end
  end

  describe "POST /battles/" do
    context "when information is provided correctly"
      it "returns a 200 OK" do
       battle_params = {:player_one => "gittheking", :player_two => "johnrbell"}
       post "/api/v1/battles", as: :json, params: { players: battle_params }
       expect(response).to be_success
      end
  end
end
