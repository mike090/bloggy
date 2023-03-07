# frozen_string_literal: true

module Yumi
  module Presenters
    class Relationships
      def initialize(options)
        @options = options
        @url = options[:url]
        @plural = @options[:names][:plural]
        @resource = options[:resource]
        @relationships = options[:relationships]
      end

      def to_json_api
        @relationships.each_with_object({}) do |relationship, result|
          result[relationship] = presenter(relationship).new(@url,
                                                             @resource.send(relationship),
                                                             prefix).as_relationship
        end
      end

      private

      def prefix
        @prefix ||= "#{@plural}/#{@resource.id}/"
      end

      def presenter(relationship)
        "Presenters::#{relationship.to_s.singularize.capitalize}".constantize
      end
    end
  end
end
