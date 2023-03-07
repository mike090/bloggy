# frozen_string_literal: true

module Yumi
  module Presenters
    class IncludedResources
      def initialize(options)
        @options = options
        @url = @options[:url]
        @resource = @options[:resource]
        @relationships = @options[:relationships]
        @included_resourses = {}
      end

      def to_json_api
        if @resource.respond_to?(:each)
          @resource.each { |r| included_data(r, @included_resourses) }
        else
          included_data(@resource, @included_resourses)
        end
        @included_resourses.values
      end

      private

      def included_data(resource, result)
        @relationships.each do |rel|
          resource.send(rel).each do |associated_resource|
            key = "#{rel}:#{associated_resource.id}"
            result[key] = presenter(rel).new(@url, associated_resource).as_included unless result[key]
          end
        end
      end

      def presenter(rel)
        "Presenters::#{rel.to_s.singularize.capitalize}".constantize
      end
    end
  end
end
