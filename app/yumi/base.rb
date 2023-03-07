# frozen_string_literal: true

require_relative 'class_methods'

module Yumi
  class Base
    extend Yumi::ClassMethods

    def initialize(url, resource, prefix = nil)
      name = self.class.name
      @options = { presenter: self, url:, resource:, prefix:,
                   names: {
                     demodulized: name.demodulize,
                     singular: name.demodulize.downcase,
                     plural: name.demodulize.downcase.pluralize
                   } }
      set_instance_variables
    end

    def as_json_api
      {
        meta: @options[:meta],
        data: Yumi::Presenters::Resource.new(@options).to_json_api,
        links: Yumi::Presenters::Links.new(@options).to_json_api,
        included: Yumi::Presenters::IncludedResources.new(@options).to_json_api
      }
    end

    def as_relationship
      {
        data: @options[:resource].map { |c| { type: @options[:names][:plural], id: c.id.to_s } },
        links: {
          self: "#{@options[:url]}/#{@options[:prefix]}relationships/#{@options[:names][:plural]}",
          related: "#{@options[:url]}/#{@options[:prefix]}#{@options[:names][:plural]}"
        }
      }
    end

    def as_included
      {
        type: @options[:names][:plural],
        id: @options[:resource].id.to_s,
        attributes: Yumi::Presenters::Attributes.new(@options).to_json_api,
        links: Yumi::Presenters::Links.new(@options).to_json_api
      }
    end

    private

    def set_instance_variables
      @options[:meta] = self.class.send('_meta') || {}
      %i[relationships links attributes].each do |v|
        @options[v] = self.class.send("_#{v}") || []
      end
    end
  end
end
