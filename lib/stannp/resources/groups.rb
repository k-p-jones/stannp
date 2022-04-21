# frozen_string_literal: true

module Stannp
  class GroupsResource < Resource
    def list(offset: nil, limit: nil)
      params = { offset: offset, limit: limit }
      url = url_for(path: 'groups/list', params: params)
      List.from_request(data: get_request(url).body['data'], type: Group)
    end

    def create(name:)
      url = url_for(path: 'groups/new')
      Group.new(post_request(url, body: { name: name }).body['data'])
    end

    def add_recipients(id:, recipient_ids:)
      url = url_for(path: "groups/add/#{id}")
      ids = recipient_ids.is_a?(Array) ? recipient_ids.join(',') : recipient_ids
      post_request(url, body: { recipients: ids }).body['success']
    end

    def remove_recipients(id:, recipient_ids:)
      url = url_for(path: "groups/remove/#{id}")
      ids = recipient_ids.is_a?(Array) ? recipient_ids.join(',') : recipient_ids
      post_request(url, body: { recipients: ids }).body['success']
    end

    def delete(id:)
      url = url_for(path: "groups/delete/#{id}")
      post_request(url, body: { id: id }).body['success']
    end

    def purge(id:, delete_recipients: false)
      url = url_for(path: "groups/purge/#{id}")
      post_request(url, body: { id: id, delete_recipients: delete_recipients }).body['success']
    end
  end
end
