# frozen_string_literal: true

module Stannp
  class AccountResource < Resource
    def balance
      url = url_for(path: 'accounts/balance')
      get_request(url).body['data']['balance']
    end

    def top_up(amount:)
      url = url_for(path: 'accounts/topup')
      url = post_request(url, body: { net: amount.to_f.to_s }).body['data']['receipt_pdf']
      Stannp::Receipt.new(url: url)
    end
  end
end
