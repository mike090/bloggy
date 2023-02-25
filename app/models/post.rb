# frozen_string_literal: true

class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :slug, type: String
  field :title, type: String
  field :content, type: String

  embeds_many :tags
  embeds_many :comments

  scope :as_created, -> { order('created_at DESC') }

  validates :slug, presence: true, uniqueness: true
  validates :title, presence: true

  index({ slug: 1 }, { unique: true, name: 'slug_index' })
end
