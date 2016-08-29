module OmniauthTestHelper
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
end
