# frozen_string_literal: true

module Stannp
  class UserResource < Resource
    def get
      url = "https://dash.stannp.com/api/v1/users/me?api_key=#{client.api_key}"
      User.new(get_request(url).body['data'])
    end
  end
end
