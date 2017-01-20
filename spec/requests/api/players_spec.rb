require "support/factory_girl"
require "rails_helper"

describe "Players API" do
  before(:each) do
    Player.create(
      login: "github_user",
      followers: 1,
      public_repos: 2,
      avatar_url: "some_image.jpg",
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

    context "when the id is invalid" do
      it "returns a 404 status" do
        get "/api/v1/players/99999999999999999999999999999999999999999"
        expect(response.status).to eq 404
      end

      it "responds with message of Not Found" do
        get "/api/v1/players/99999999999999999999999999999999999999999"
        message = JSON.parse(response.body)["error"]
        expect(message).to eq "Not Found"
      end
    end
  end

  describe "GET /players/lists/leaderboard" do
    it "returns a 200 OK" do
      get "/api/v1/players/lists/leaderboard"
      expect(response).to be_success
    end

    it "responds with players data" do
      get "/api/v1/players/lists/leaderboard"
      data = JSON.parse(response.body)

      expect(data).to_not be_empty

      data.each do |player|
        check_player_keys player
      end
    end
  end


  describe "PUT /players/:id" do
    context "when user currently exists" do
      it "returns a 200 OK" do
        id = Player.first.id
        rand_num = rand(10)
        player_params = { :id => id, :followers => rand_num  }
        put "/api/v1/players/#{id}", as: :json, params: { player: player_params }
        expect(response).to be_success
      end

      it "updates info correctly" do
        id = Player.first.id
        rand_num = rand(10)
        player_params = { :id => id, :followers => rand_num  }
        put "/api/v1/players/#{id}", as: :json, params: { player: player_params }
        data = JSON.parse(response.body)
        expect(data["followers"]).to eq(rand_num)
      end
    end
  end

  describe "POST /players" do
    context "when login does not currently exist" do
      it "returns a 200 OK" do
        player_params = { :login => "another_github_user", :avatar_url => "some_image.jpg" }
        post "/api/v1/players", as: :json, params: { player: player_params }
        expect(response).to be_success
      end
    end

    context "when login does currently exist" do
      it "responds with message already exists" do
        player_params = { :login => "github_user", :avatar_url => "some_image.jpg" }
        post "/api/v1/players", as: :json, params: { player: player_params }
        message = JSON.parse(response.body)["error"]
        expect(message).to eq "That user already exists"
      end
    end
  end

  describe "GET /search/:login" do
    context "when login does currently exists in db" do
      it "returns a 200 OK" do
        player_login = Player.first.login
        get "/api/v1/search?login=#{player_login}"
        expect(response).to be_success
      end

      it "responds with players data" do
        player_login = Player.first.login
        get "/api/v1/search?login=#{player_login}"
        data = JSON.parse(response.body)

        expect(data).to_not be_empty
        check_player_keys data
      end
    end

    context "when login exists on github but not in db" do
      it "returns a 200 OK" do
        player_login = "heidipowers"
        get "/api/v1/search?login=#{player_login}"

        expect(response).to be_success
      end

      it "responds with new player data" do
        player_login = "heidipowers"
        get "/api/v1/search?login=#{player_login}"
        data = JSON.parse(response.body)

        expect(data).to_not be_empty
        check_player_keys data
      end
    end

    context "when login does not exists on github or in db" do
      it "returns a 404 not found" do
        player_login = SecureRandom.urlsafe_base64
        get "/api/v1/search?login=#{player_login}"
        expect(response.status).to eq 404
      end

      it "responds with message not found" do
        player_login = SecureRandom.urlsafe_base64
        get "/api/v1/search?login=#{player_login}"
        data = JSON.parse(response.body)

        message = JSON.parse(response.body)["error"]
        expect(message).to eq "Not Found"
      end
    end
  end
end
