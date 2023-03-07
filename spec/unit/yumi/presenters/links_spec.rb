# frozen_string_literal: true

RSpec.describe Yumi::Presenters::Links do
  describe '#to_json_api' do
    let(:links) { %i[self] }

    let(:options) do
      {
        url: BASE_URL,
        resource:,
        names: { plural: 'resources' },
        links:
      }
    end

    let(:target) { described_class.new(options) }

    context 'when resource is collection' do
      let(:resource) { [double('SomeResource', id: '1')] }

      it 'returns /resources' do
        expect(target.to_json_api).to eq({
                                           self: "#{BASE_URL}/resources"
                                         })
      end
    end

    context 'when single resource' do
      let(:resource) { double('SomeResource', id: '1') }
      it 'return /resources/1' do
        expect(target.to_json_api).to eq({
                                           self: "#{BASE_URL}/resources/1"
                                         })
      end
    end
  end
end
