# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  sequence :slug do |_n|
    Faker::Internet.slug
  end

  sequence :tag_name do |_n|
    Faker::Lorem.word
  end

  sequence :author do |_n|
    Faker::Name.name
  end

  sequence :email do |_n|
    Faker::Internet.email
  end

  sequence :website do |_n|
    Faker::Internet.domain_name subdomain: true
  end

  sequence :content do |_n|
    Faker::Lorem.paragraph
  end

  sequence :title do |_n|
    Faker::Lorem.sentence
  end
end
