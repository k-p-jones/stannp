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

    def create(attributes:)
      url = "https://dash.stannp.com/api/v1/recipients/new?api_key=#{client.api_key}"
      Recipient.new(post_request(url, body: attributes).body['data'])
    end

    def delete(id:)
      url = "https://dash.stannp.com/api/v1/recipients/delete?api_key=#{client.api_key}"
      post_request(url, body: { id: id.to_i })
      true
    end

    def delete_all
      url = "https://dash.stannp.com/api/v1/recipients/deleteAll?api_key=#{client.api_key}"
      post_request(url, body: { delete_all: true })
      true
    rescue Stannp::Error => e
      # Despite the request actually deleteing all recipients, the API returns a 400. In those
      # cases, and when delete all is called on an empty recipient list, just return true.
      return true if e.message == '400: Nothing to delete'

      raise e
    end

    def import(group_id:, file:, options: {})
      url = "https://dash.stannp.com/api/v1/recipients/import?api_key=#{client.api_key}"
      body = { group_id: group_id, file: file }.merge(options)
      post_request(url, body: body).body['success']
    end
  end
end
