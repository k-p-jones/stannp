# frozen_string_literal: true

module Stannp
  class Resource
    def initialize(client:)
      @client = client
    end

    def get_request(url, params: {}, headers: {})
      handle_response(client.connection.get(url, params, headers))
    end

    def post_request(url, body:, headers: {})
      handle_response client.connection.post(url, body, headers)
    end

    def url_for(path:)
      "#{path}?api_key=#{client.api_key}"
    end

    private

    attr_reader :client

    def handle_response(response)
      raise Error, "#{response.status}: #{response.body["error"]}" unless response.success?

      response
    end
  end
end
