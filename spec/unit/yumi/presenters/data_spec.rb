# frozen_string_literal: true

RSpec.describe Yumi::Presenters::Data do
  let(:resource) { instance_double('MyDataResource', id: '1') }
  let(:options) do
    {
      resource:,
      names: { plural: 'resources' }
    }
  end
  let(:target) { Yumi::Presenters::Data.new(options) }

  before do
    allow_any_instance_of(Yumi::Presenters::Attributes).to receive(:to_json_api).and_return('attributes')
    allow_any_instance_of(Yumi::Presenters::Links).to receive(:to_json_api).and_return('links')
    allow_any_instance_of(Yumi::Presenters::Relationships).to receive(:to_json_api).and_return('relationships')
  end

  describe '#to_json_api' do
    it 'returns expected data hash' do
      expect(target.to_json_api).to eq(
        {
          type: 'resources',
          id: '1',
          attributes: 'attributes',
          links: 'links',
          relationships: 'relationships'
        }
      )
    end
  end
end
