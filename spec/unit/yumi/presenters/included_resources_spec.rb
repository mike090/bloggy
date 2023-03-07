# frozen_string_literal: true

module Yumi
  module IncludeResourcesTests
    class Base
      def initialize(url, res)
        @url = url
        @res = res
      end

      def as_included; end
    end
  end
end

module Presenters
  class Car < Yumi::IncludeResourcesTests::Base
    def as_included = 'car'
  end

  class Bike < Yumi::IncludeResourcesTests::Base
    def as_included = 'bike'
  end
end

RSpec.describe Yumi::Presenters::IncludedResources do
  let(:my_cars) do
    [
      instance_double('Car', id: '123', type: 'lambo1'),
      instance_double('Car', id: '123', type: 'lambo2'),
      instance_double('Car', id: '234', type: 'ferrary'),
      instance_double('Car', id: '345', type: 'ford')
    ]
  end

  let(:my_bikes) do
    [
      instance_double('Bike', id: '456', type: 'ducati'),
      instance_double('Bike', id: '567', type: 'hd')
    ]
  end

  let(:my_garage) { instance_double('MyGarage', cars: my_cars, bikes: my_bikes) }

  let(:options) do
    {
      url: BASE_URL,
      resource:,
      names: { plural: 'garages' },
      relationships: %i[cars bikes]
    }
  end
  let(:target) { Yumi::Presenters::IncludedResources.new(options) }

  describe '#to_json_api' do
    context 'when resource is a collection' do
      let(:resource) { [my_garage, my_garage] }

      it 'returns an array of included resources withoot duplicates' do
        expect(target.to_json_api).to eq(%w[car car car bike bike])
      end
    end

    context 'when resource is single' do
      let(:resource) { my_garage }

      it 'returns an array of included resources withoot duplicates' do
        expect(target.to_json_api).to eq(%w[car car car bike bike])
      end
    end
  end

  describe '#presenter' do
    let(:resource) { 'whatever' }

    it 'returns the Presenters::Car presenter' do
      expect(target.send(:presenter, :cars)).to eq(Presenters::Car)
    end
  end
end
