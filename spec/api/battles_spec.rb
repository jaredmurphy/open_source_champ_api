require 'support/factory_girl'
require 'rails_helper'


describe "Battles API" do
  it 'sends a list of battles' do
    get '/api/v1/battles'
  #  byebug
    expect(response).to be_success
  end
end
