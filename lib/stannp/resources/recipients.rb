# frozen_string_literal: true

module Stannp
  class RecipientsResource < Resource
    def list(group_id: nil)
      id = group_id ? "/#{group_id}" : ''
      url = "https://dash.stannp.com/api/v1/recipients/list#{id}?api_key=#{client.api_key}"
      List.from_request(data: get_request(url).body['data'], type: Recipient)
    end

    def get(id:)
      url = "https://dash.stannp.com/api/v1/recipients/get/#{id}?api_key=#{client.api_key}"
      Recipient.new(get_request(url).body['data'])
    end
  end
end
