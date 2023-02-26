# frozen_string_literal: true

module API
  module V1
    class Posts < Grape::API
      version 'v1', using: :path, vendor: 'samurails-blog'

      resources :posts do
        desc 'Returns all posts'
        get do
          Post.all.as_created
        end

        desc 'Return a specific post'
        params do
          requires :id, type: String
        end
        get ':id' do
          Post.find(params[:id])
        end
      end
    end
  end
end
