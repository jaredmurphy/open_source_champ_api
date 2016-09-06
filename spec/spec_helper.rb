
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  
  #config.include OmniauthTestHelper
  
  def valid_github_login_setup
    if Rails.env.test?
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = 
        OmniAuth::AuthHash.new({
          'uid' => '28395028',
          'provider' => 'github',
          'extra' => {
            'raw_info' => {
              'login': 'JohnDoe'
            }
          }
        })
    end
  end

  def check_player_keys player
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
