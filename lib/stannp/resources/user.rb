# frozen_string_literal: true

module Stannp
  class UserResource < Resource
    def get
      url = url_for(path: 'users/me')
      User.new(get_request(url).body['data'])
    end
  end
end
