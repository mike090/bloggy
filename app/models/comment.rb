# frozen_string_literal: true

class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :author, type: String
  field :email, type: String
  field :website, type: String
  field :content, type: String

  embedded_in :post

  validates :author, presence: true
  validates :content, presence: true
end
