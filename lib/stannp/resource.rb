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

    def patch_request(url, body:, headers: {})
      handle_response client.connection.patch(url, body, headers)
    end

    def put_request(url, body:, headers: {})
      handle_response client.connection.put(url, body, headers)
    end

    private

    attr_reader :client

    def handle_response(response)
      raise Error, "#{response.status}: #{response.body["error"]}" unless response.success?

      response
    end
  end
end
