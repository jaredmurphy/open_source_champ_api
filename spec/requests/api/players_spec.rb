require "support/factory_girl"
require "rails_helper"

describe "Players API" do
  before(:each) do
    Player.create(
      login: "schmartmann",
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
        check_player_keys player
      end 
    end
  end

  describe "GET /players/:id" do
    context "when the id is valid" do
      it "returns a 200 OK" do
        player = Player.first

        get "/api/v1/players/#{player.id}"
        expect(response).to be_success

        data = JSON.parse(response.body)
        expect(data).to_not be_empty
        check_player_keys data
      end
    end

    context "when the login is passed" do
      it "returns a 200 Ok" do
        player = Player.first
        get "/api/v1/players/#{player.login}"
        expect(response).to be_success

        data = JSON.parse(response.body)
        expect(data).to_not be_empty

        check_player_keys data
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
        player_params = { :login => "Shit fuck mother fucker"  }
        post "/api/v1/players", as: :json, params: { player: player_params }
        expect(response).to be_success
      end
    end
  end

  describe "PUT /players/:id" do
    context "when user currently exists" do
      it "returns a 200 OK" do
        rand_num = rand(10)
        player_params = { :login => "schmartmann", followers: rand_num  }
        post "/api/v1/players", as: :json, params: { player: player_params }
        expect(response).to be_success
      end

      it "updates info correctly" do
        rand_num = rand(10)
        player_params = { :login => "schmartmann", followers: rand_num  }
        post "/api/v1/players", as: :json, params: { player: player_params }
        data = JSON.parse(response.body)
        expect(data["followers"]).to eq(rand_num)
      end
    end
  end
end 
