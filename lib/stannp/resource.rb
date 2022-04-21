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

    def url_for(path:, params: nil)
      url = "#{path}?api_key=#{client.api_key}"
      params&.each do |k, v|
        next unless v

        url += "&#{k}=#{v}"
      end
      url
    end

    private

    attr_reader :client

    def handle_response(response)
      raise Error, "#{response.status}: #{response.body["error"]}" unless response.success?

      response
    end
  end
end
