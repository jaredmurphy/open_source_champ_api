require "support/factory_girl"
require "rails_helper"

describe "Battles API" do
  before(:each) do
    @player_one = Player.create(
      login: "johnrbell",
      avatar_url: "some_img.jpg",
      followers: 1,
      following: 2,
      public_repos: 3,
      public_gists: 4
    )
    @player_two = Player.create(
      login: "gittheking",
      avatar_url: "some_img.jpg",
      followers: 5,
      following: 6,
      public_repos: 7,
      public_gists: 8
    )

    @player_three = Player.create(
      login: "heidipowers",
      avatar_url: "some_img.jpg",
      followers: 8,
      following: 2,
      public_repos: 37,
      public_gists: 10000
    )

    @battle_one = Battle.create(
      winner_score: 10,
      loser_score: 1,
      winner_id: @player_one.id,
      loser_id: @player_two.id
    )

    @battle_two = Battle.create(
      winner_score: 299,
      loser_score: 7,
      winner_id: @player_one.id,
      loser_id: @player_three.id
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

  describe "GET /battles/lists/recent" do
    it "returns a 200 OK" do
      battles = Battle.all
      
      get "/api/v1/battles/lists/recent" 
      expect(response).to be_success
    end

    it "responds with recent battle data" do
     get "/api/v1/battles/lists/recent"
     data = JSON.parse(response.body)

     expect(data).to_not be_empty

     data.each do |battle|
       expect(battle.keys).to contain_exactly("id", "winner_score", "loser_score", "created_at", "updated_at", "winner_id", "loser_id")
     end
    end

    it "responds with list in order of newest" do
     get "/api/v1/battles/lists/recent"
     data = JSON.parse(response.body)
     correct_order = data.first["created_at"] > data.last["created_at"]
     expect(correct_order).to be(true)
    end
  end


  describe "POST /battles/" do
    context "when information is provided correctly"
      it "returns a 200 OK" do
        battle_params = {:player_one => Player.first.id, :player_two => Player.second.id}
        post "/api/v1/battles", as: :json, params: { players: battle_params }
        expect(response).to be_success
      end

      it "responds with battle data" do
        battle_params = {:player_one => Player.first.id, :player_two => Player.second.id}
        post "/api/v1/battles", as: :json, params: { players: battle_params }
        data = JSON.parse(response.body)

        expect(data).to_not be_empty
        expect(data.keys).to contain_exactly("id", "winner_score", "loser_score", "created_at", "updated_at", "winner_id", "loser_id")
      end
  end
end
