# frozen_string_literal: true

require 'grape'
require 'mongoid'

Mongoid.load! 'config/mongoid.config'

Dir["#{File.dirname(__FILE__)}/app/models/**/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/app/api/**/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/app/yumi/**/*.rb"].each { |f| require f }

module API
  class Root < Grape::API
    format :json
    prefix :api
    cascade false

    get :status do
      { status: 'ok' }
    end

    mount V1::Admin::Posts
    mount V1::Posts
    mount V1::Comments
  end
end

BlogApp = Rack::Builder.new do
  map '/' do
    run API::Root
  end
end
