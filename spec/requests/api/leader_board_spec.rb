require "rails_helper"

describe "Leaderboard API" do
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

  describe "GET /leaderboard" do
    it "returns a 200 OK" do
      get "/api/v1/leaderboard"
      expect(response).to be_success
    end

    it "responds with a list of players" do
     get "/api/v1/leaderboard"
     data = JSON.parse(response.body)

     expect(data).to_not be_empty

     #data.each do |battle|
       #expect(battle.keys).to contain_exactly("id", "winner_score", "loser_score", "created_at", "updated_at", "winner_id", "loser_id")
     #end
    end
  end
end


