# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

module Stannp
  class Client
    attr_reader :api_key, :adapter

    def initialize(api_key:, adapter: Faraday.default_adapter)
      @api_key = api_key
      @adapter = adapter
    end

    def account
      AccountResource.new(client: self)
    end

    def user
      UserResource.new(client: self)
    end

    def recipients
      RecipientsResource.new(client: self)
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.request :json
        conn.response :json, content_type: 'application/json'
        conn.adapter adapter
      end
    end
  end
end
