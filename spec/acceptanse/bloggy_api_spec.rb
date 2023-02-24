# frozen_string_literal: true

RSpec.describe 'bloggy api' do
  include Rack::Test::Methods

  def app
    API::Root
  end

  it 'returns health status' do
    get '/api/status'
    expect(last_response.status).to eq(200)
  end
end
