# frozen_string_literal: true

module Yumi
  module ClassMethods
    attr_reader :_attributes, :_links, :_meta, :_relationships

    def attributes(*args)
      @_attributes = args
    end

    def links(*args)
      @_links = args
    end

    def meta(meta_data)
      @_meta = meta_data
    end

    def has_many(*args)
      @_relationships = args
    end
  end
end
