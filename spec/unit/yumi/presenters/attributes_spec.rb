# frozen_string_literal: true

# Resource = Struct.new(:description, :slug)
# Presenter = Struct.new(:whatever)

RSpec.describe Yumi::Presenters::Attributes do
  let(:attributes) { %i[description slug] }
  let(:resource) { double('SomeResource', description: "I'm a resource", slug: 'whatever') }
  let(:presenter) { double('Presenter') }

  let(:options) do
    {
      attributes:,
      resource:,
      presenter:
    }
  end

  let(:target) { described_class.new(options) }

  describe '#to_json_api' do
    context 'without presenter overrides' do
      it 'return a hash with the resource attributes' do
        expect(target.to_json_api).to eq({
                                           description: "I'm a resource",
                                           slug: 'whatever'
                                         })
      end
    end

    context 'with presenter overrides' do
      before do
        allow(presenter).to receive(:description)
          .and_return("I'm a presenter")
      end

      it 'return a hash with the presenter overridden' do
        expect(target.to_json_api).to eq({
                                           description: "I'm a presenter",
                                           slug: 'whatever'
                                         })
      end
    end
  end
end
