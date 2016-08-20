
Winner.destroy_all
Loser.destroy_all
Battle.destroy_all
Player.destroy_all

Player.create([
  {
      :github_id => 617982,
      :login => "bryanmytko",
      :avatar_url => "https://avatars.githubusercontent.com/u/617982?v=3",
      :blog => "twitter.com/bryanmytko",
      :github_created_at => "2011-02-14T20:34:32Z",
      :followers => 30,
      :following => 12,
      :public_repos => 64,
      :public_gists => 1,
      :company => "@GA-WDI ",
      :location => "Queens, NY",
      :github_url => "https://github.com/bryanmytko",
      :kind => "User",
      :bio => "Not a wizard, ninja, guru or rockstar."
  },
  {
      :github_id => 19958555,
      :login => "schmartmann",
      :avatar_url => "https://avatars.githubusercontent.com/u/19958555?v=3",
      :blog => "",
      :github_created_at => "2011-02-14T20:34:32Z",
      :followers => 1,
      :following => 1,
      :public_repos => 4,
      :public_gists => 0,
      :location => "",
      :company => "",
      :github_url => "https://github.com/schmartmann",
      :kind => "User",
      :bio => "Not a wizard, ninja, guru or rockstar."
  }
])

Battle.create([{ :winner_score => 100, :loser_score => 10 }])

Winner.create([{ :player_id => 1, :battle_id => 1 }])

Loser.create([{ :player_id => 2, :battle_id => 1 }])

puts "Created #{Player.count} players"
puts "Created #{Battle.count} battles"
puts "Created #{Winner.count} winners"
puts "Created #{Loser.count} losers"
