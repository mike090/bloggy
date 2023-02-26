# frozen_string_literal: true

RSpec.describe 'bloggy api', :db_depended do
  include Rack::Test::Methods

  def app
    API::Root
  end

  let(:blog_post) { create :post }
  let(:post_with_comments) do
    create :post do |post|
      post.comments.create(attributes_for(:comment))
    end
  end
  let(:post_for_deletion) { create :post }

  it 'returns health status' do
    get '/api/status'
    expect(last_response.status).to eq(200)
  end

  describe 'Client endpoints' do
    it 'returns all posts' do
      get '/api/v1/posts'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to be_a Array
    end

    it 'return a specific post' do
      get "/api/v1/posts/#{blog_post.id}"
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to include(blog_post.attributes.slice('slug', 'title', 'content'))
    end

    it 'add submitted comment to post' do
      comment = attributes_for(:comment).transform_keys(&:to_s)
      post "/api/v1/post/#{blog_post.id}/comments", comment
      expect(last_response.status).to eq(201)
      blog_post.reload
      expect(blog_post.comments.first.attributes).to include(comment)
    end

    it 'update specific comment' do
      update_values = attributes_for(:comment)
      put "/api/v1/post/#{post_with_comments.id}/comments/#{post_with_comments.comments.first.id}", update_values
      expect(last_response.status).to eq(200)
      post_with_comments.reload
      expect(post_with_comments.comments.first.attributes).to include(update_values.transform_keys(&:to_s))
    end

    it 'delete comment' do
      delete "/api/v1/post/#{post_with_comments.id}/comments/#{post_with_comments.comments.first.id}"
      expect(last_response.status).to eq(200)
      post_with_comments.reload
      expect(post_with_comments.comments).to be_empty
    end
  end

  describe 'Admin endpoints' do
    it 'returns all posts' do
      get '/api/v1/admin/posts'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to be_a(Array)
    end

    it 'return a specific post' do
      get "/api/v1/admin/posts/#{blog_post.id}"
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to include(blog_post.attributes.slice('slug', 'title', 'content'))
    end

    it 'add submitted post' do
      new_post = attributes_for(:post)
      post '/api/v1/admin/posts', new_post
      expect(last_response.status).to eq(201)
      id = JSON.parse(last_response.body)['_id']['$oid']
      expect(Post.find(id).attributes).to include(new_post.transform_keys(&:to_s))
    end

    it 'update a post' do
      update_values = attributes_for :post
      put "/api/v1/admin/posts/#{blog_post.id}", update_values
      expect(last_response.status).to eq(200)
      blog_post.reload
      expect(blog_post.attributes).to include(update_values.transform_keys(&:to_s))
    end

    it 'delete a post' do
      delete "/api/v1/admin/posts/#{post_for_deletion.id}"
      expect(last_response.status).to eq(200)
      expect { Post.find post_for_deletion.id }.to raise_error(Mongoid::Errors::DocumentNotFound)
    end
  end
end
