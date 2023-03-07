# frozen_string_literal: true

module Yumi
  module Presenters
    class Attributes
      def initialize(options)
        @options = options
        @attributes = @options[:attributes]
        @resource = @options[:resource]
        @presenter = @options[:presenter]
      end

      def to_json_api
        @attributes.each_with_object({}) do |attr, result|
          result[attr] = (@presenter.respond_to?(attr) ? @presenter : @resource).send(attr)
        end
      end
    end
  end
end
