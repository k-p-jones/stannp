# frozen_string_literal: true

module Stannp
  class List
    attr_reader :data

    def self.from_request(data:, type:)
      new(data: data.map { |attrs| type.new(attrs) })
    end

    def initialize(data:)
      @data = data
    end
  end
end
