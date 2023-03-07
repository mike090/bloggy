# frozen_string_literal: true

FAKE_META_DATA = { some: 'stuff' }.freeze

module Fake
  class Post < ::Yumi::Base
    meta FAKE_META_DATA
    attributes :one, :two, :three
    has_many :things, :cars
    links :self
  end
end

RSpec.describe Yumi::ClassMethods do
  let(:url) { BASE_URL }
  let(:presenter) { Fake::Post.new(url, []) }

  describe '.meta' do
    it 'assiggns the meta value to the class instance _meta' do
      expect(Fake::Post._meta).to eq(FAKE_META_DATA)
    end

    it 'adds the meta value in the options hash for a new instance' do
      # presenter = Fake::Post.new(url, [])
      expect(presenter.instance_variable_get('@options')[:meta]).to eq(FAKE_META_DATA)
    end
  end

  describe '.attributes' do
    it 'assiggns the attributes value to the class instance _attributes' do
      expect(Fake::Post._attributes).to eq(%i[one two three])
    end

    it 'adds the attributes value in the options hash for a new instance' do
      # presenter = Fake::Post.new(url, [])
      expect(presenter.instance_variable_get('@options')[:attributes]).to eq(%i[one two three])
    end
  end

  describe '.has_many' do
    it 'assigns the relationships value to the class instance _relationships' do
      expect(Fake::Post._relationships).to eq(%i[things cars])
    end

    it 'adds the relationships value in the options hash for a new instance' do
      # presenter = Fake::Post.new(url, [])
      expect(presenter.instance_variable_get('@options')[:relationships]).to eq(%i[things cars])
    end
  end

  describe '.links' do
    it 'assigns the links value to the class instance _links' do
      expect(Fake::Post._links).to eq([:self])
    end

    it 'adds the links value in the options hash for a new instance' do
      presenter = Fake::Post.new(url, [])
      expect(presenter.instance_variable_get('@options')[:links]).to eq([:self])
    end
  end
end
