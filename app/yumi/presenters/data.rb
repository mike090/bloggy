# frozen_string_literal: true

module Yumi
  module Presenters
    class Data
      def initialize(options)
        @options = options
        @url = options[:url]
        @resource = options[:resource]
        @plural = options[:names][:plural]
      end

      def to_json_api
        {
          type: @plural,
          id: @resource.id.to_s,
          attributes: Yumi::Presenters::Attributes.new(@options).to_json_api,
          links: Yumi::Presenters::Links.new(@options).to_json_api,
          relationships: Yumi::Presenters::Relationships.new(@options).to_json_api
        }
      end
    end
  end
end
