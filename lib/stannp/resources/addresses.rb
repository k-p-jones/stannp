# frozen_string_literal: true

module Stannp
  class AddressesResource < Resource
    def validate(attributes:)
      url = url_for(path: 'addresses/validate')
      post_request(url, body: attributes).body['data']['is_valid']
    end
  end
end
