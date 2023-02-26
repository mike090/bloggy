# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    author
    email
    website
    content
    association :post, factory: :post
  end
end
