require "support/factory_girl"
require "rails_helper"

describe "Players API" do
  before(:each) do
    Player.create(
      login: "player1",
      followers: 1,
      public_repos: 2,
      github_url: "www.github.com/player1"
    )
  end

  describe "GET /players" do
    it "returns a 200 OK" do
      get "/api/v1/players"
      expect(response).to be_success
    end

    it "responds with players data" do
      get "/api/v1/players"
      data = JSON.parse(response.body)

      expect(data).to_not be_empty

      data.each do |player|
        expect(player.keys).to contain_exactly(
          "id", 
          "github_id",
          "login", 
          "avatar_url",
          "blog",
          "github_created_at",
          "followers",
          "following",
          "public_repos",
          "public_gists",
          "location",
          "company",
          "created_at",
          "updated_at",
          "github_url",
          "kind",
          "bio"
        )
      end
    end
  end

  describe "GET /players/:id" do
    context "when the id is valid" do
      it "returns a 200 OK" do
        player = Player.first

        get "/api/v1/players/#{player.id}"
        expect(response).to be_success
      end
    end

    context "when the id is invalid" do
      it "returns a 404 status" do
        get "/api/v1/players/9000"
        expect(response.status).to eq 404
      end

      it "responds with message of Not Found" do
        get "/api/v1/players/9000"
        message = JSON.parse(response.body)["error"]
        expect(message).to eq "Not Found"
      end
    end
  end

  describe "POST /players" do
    context "when params are provided correctly" do
      it "returns a 200 OK" do
        post "/api/v1/players", Player.last
        expect(response).to be_success
      end
    end
  end

end

