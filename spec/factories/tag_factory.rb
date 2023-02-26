# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    slug
    name { generate :tag_name }
    association :post, factory: :post
  end
end
