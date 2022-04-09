# frozen_string_literal: true

module Stannp
  class AccountResource < Resource
    def balance
      url = "https://dash.stannp.com/api/v1/accounts/balance?api_key=#{client.api_key}}"
      get_request(url).body['data']['balance']
    end
  end
end
