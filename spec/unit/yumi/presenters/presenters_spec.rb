# frozen_string_literal: true

module Yumi
  module RelationshipsTest
    class Base
      def initialize(url, res, prefix)
        @url = url
        @res = res
        @prefix = prefix
      end

      def as_relationships; end
    end
  end
end

module Presenters
  class Bicycle < Yumi::RelationshipsTest::Base
    def as_relationship
      'bicycles!'
    end
  end

  class Skate < Yumi::RelationshipsTest::Base
    def as_relationship
      'skates!'
    end
  end
end

RSpec.describe Yumi::Presenters::Relationships do
  let(:my_garage) { instance_double('MyGarage', id: '1', skates: %w[lambo ferrary ford], bicycles: %w[ducati yamaha]) }

  let(:options) do
    {
      url: BASE_URL,
      resource: my_garage,
      names: { plural: 'garages' },
      relationships: %i[bicycles skates]
    }
  end

  let(:target) { Yumi::Presenters::Relationships.new(options) }

  describe '#to_json_api' do
    it 'returns the relationships hash' do
      expect(target.to_json_api).to eq({
                                         bicycles: 'bicycles!',
                                         skates: 'skates!'
                                       })
    end
  end

  describe '#prefix' do
    it 'returns expected prefix' do
      expect(target.send(:prefix)).to eq('garages/1/')
    end
  end

  describe '#presenter' do
    it 'returns expected presenter class' do
      expect(target.send(:presenter, :bicycles)).to eq(Presenters::Bicycle)
    end
  end
end
