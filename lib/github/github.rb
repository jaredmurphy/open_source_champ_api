module Github
  class Client
    BASE_URL = "https://api.github.com"
    GITHUB_ID = ENV['GITHUB_ID'] || ""
    GITHUB_SECRET = ENV['GITHUB_SECRET'] || ""
    AUTH_STRING = "client_id=" + GITHUB_ID + "&client_secret=" + GITHUB_SECRET

    def initialize
    end

    def player(player)
      url = BASE_URL + "/users/" + player[:login] + "?" + AUTH_STRING
      HTTParty.get(url)
    end
  end
end
