# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

module Stannp
  class Client
    BASE_URL = 'https://dash.stannp.com/api/v1'
    attr_reader :api_key, :adapter

    def initialize(api_key:, adapter: Faraday.default_adapter, stubs: nil)
      @api_key = api_key
      @adapter = adapter
      @stubs = stubs
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

    def addresses
      AddressesResource.new(client: self)
    end

    def postcards
      PostcardsResource.new(client: self)
    end

    def letters
      LettersResource.new(client: self)
    end

    def groups
      GroupsResource.new(client: self)
    end

    def campaigns
      CampaignsResource.new(client: self)
    end

    def events
      EventsResource.new(client: self)
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.request :json
        conn.response :json, content_type: 'application/json'
        conn.adapter adapter, stubs
      end
    end

    private

    attr_reader :stubs
  end
end
