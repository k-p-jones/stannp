# frozen_string_literal: true

module Stannp
  class AccountResource < Resource
    def get
      url = "https://dash.stannp.com/api/v1/accounts/balance?api_key=#{client.api_key}}"
      Account.new(get_request(url).body['data'])
    end
  end
end
