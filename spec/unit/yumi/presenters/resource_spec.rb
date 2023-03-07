# frozen_string_literal: true

RSpec.describe Yumi::Presenters::Resource do
  let(:links) { [:self] }
  let(:options) { { resource:, names: { plural: 'resources' } } }
  let(:target) { Yumi::Presenters::Resource.new(options) }

  before do
    allow_any_instance_of(Yumi::Presenters::Data).to receive(:to_json_api).and_return('resource_data!')
  end

  describe '#to_json_api' do
    context 'when resource is a collection' do
      let(:resource) { [instance_double('MyResource'), instance_double('MyResource')] }

      it 'returns array' do
        expect(target.to_json_api).to eq(%w[resource_data! resource_data!])
      end
    end

    context 'when resource is a single' do
      let(:resource) { instance_double('MyResource') }

      it 'returns resource_data!' do
        expect(target.to_json_api).to eq('resource_data!')
      end
    end
  end
end
