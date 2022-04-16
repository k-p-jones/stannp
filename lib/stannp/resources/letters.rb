# frozen_string_literal: true

module Stannp
  class LettersResource < Resource
    def create(attributes:)
      url = url_for(path: 'letters/create')
      Letter.new(post_request(url, body: attributes).body['data'])
    end

    def post(attributes:)
      url = url_for(path: 'letters/post')
      Letter.new(post_request(url, body: attributes).body['data'])
    end

    def get(id:)
      url = url_for(path: "letters/get/#{id}")
      Letter.new(get_request(url).body['data'])
    end

    def cancel(id:)
      url = url_for(path: 'letters/cancel')
      post_request(url, body: { id: id }).body['success']
    end

    def batch(attributes:)
      url = url_for(path: 'letters/batch')
      Batch.new(post_request(url, body: attributes).body['data'])
    end
  end
end
