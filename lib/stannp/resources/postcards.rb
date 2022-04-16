# frozen_string_literal: true

module Stannp
  class PostcardsResource < Resource
    def create(attributes:)
      url = url_for(path: 'postcards/create')
      Postcard.new(post_request(url, body: attributes).body['data'])
    end

    def get(id:)
      url = url_for(path: "postcards/get/#{id}")
      Postcard.new(get_request(url).body['data'])
    end

    def cancel(id:)
      url = url_for(path: 'postcards/cancel')
      post_request(url, body: { id: id }).body['success']
    end
  end
end
