# frozen_string_literal: true

module Stannp
  class AccountResource < Resource
    def balance
      url = "https://dash.stannp.com/api/v1/accounts/balance?api_key=#{client.api_key}}"
      get_request(url).body['data']['balance']
    end

    def top_up(amount:)
      url = "https://dash.stannp.com/api/v1/accounts/topup?api_key=#{client.api_key}}"
      url = post_request(url, body: { net: amount.to_f.to_s }).body['data']['receipt_pdf']
      Stannp::Receipt.new(url: url)
    end
  end
end
