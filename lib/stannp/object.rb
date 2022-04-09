# frozen_string_literal: true

require 'ostruct'

module Stannp
  class Object
    attr_reader :attributes

    def initialize(attributes)
      @attributes = OpenStruct.new(attributes)
    end

    def method_missing(method, *args, &block)
      value = attributes.send(method, *args, &block)
      case value
      when Hash
        Object.new(value)
      when Array
        value.map { |item| item.is_a?(Hash) ? Object.new(item) : item }
      else
        value
      end
    end

    def respond_to_missing?(method, include_private = false)
      attributes.to_h.keys.include?(method) || super
    end
  end
end
