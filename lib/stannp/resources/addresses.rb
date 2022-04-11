# frozen_string_literal: true

module Stannp
  class AddressesResource < Resource
    def validate(attributes:)
      url = "https://dash.stannp.com/api/v1/addresses/validate?api_key=#{client.api_key}"
      post_request(url, body: attributes).body['data']['is_valid']
    end
  end
end
