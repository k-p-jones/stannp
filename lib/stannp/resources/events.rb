# frozen_string_literal: true

module Stannp
  class EventsResource < Resource
    def create(attributes:)
      url = url_for(path: 'recipientEvents/create')
      post_request(url, body: attributes).body['data']
    end
  end
end
