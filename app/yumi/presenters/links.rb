# frozen_string_literal: true

module Yumi
  module Presenters
    class Links
      def initialize(options)
        @options = options
        @links = @options[:links]
        @url = @options[:url]
        @plural = @options[:names][:plural]
        @resource = @options[:resource]
      end

      def to_json_api
        @links.each_with_object({}) do |link_type, result|
          result[link_type] = send("#{link_type}_link")
        end
      end

      private

      def self_link
        @resource.respond_to?(:each) ? "#{@url}/#{@plural}" : "#{@url}/#{@plural}/#{@resource.id}"
      end
    end
  end
end
