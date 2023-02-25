# frozen_string_literal: true

require 'grape'
require 'mongoid'

Mongoid.load! 'config/mongoid.config'

Dir["#{File.dirname(__FILE__)}/app/models/**/*.rb"].each { |f| require f }

module API
  class Root < Grape::API
    format :json
    prefix :api
    cascade false

    get :status do
      { status: 'ok' }
    end
  end
end

BlogApp = Rack::Builder.new do
  map '/' do
    run API::Root
  end
end
