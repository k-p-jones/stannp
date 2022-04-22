# frozen_string_literal: true

module Stannp
  class CampaignsResource < Resource
    def list
      url = url_for(path: 'campaigns/list')
      List.from_request(data: get_request(url).body['data'], type: Campaign)
    end

    def get(id:)
      url = url_for(path: "campaigns/get/#{id}")
      Campaign.new(get_request(url).body['data'])
    end

    def cost(id:)
      url = url_for(path: 'campaigns/cost')
      CampaignCost.new(post_request(url, body: { id: id }).body['data'])
    end

    def available_booking_dates(start_date: nil, end_date: nil)
      url = url_for(path: 'campaigns/availableDates')
      post_request(url, body: { start: start_date, end: end_date }).body['data']
    end

    def create(attributes:)
      url = url_for(path: 'campaigns/create')
      Campaign.new(id: post_request(url, body: attributes).body['data'])
    end

    def sample_url(id:)
      url = url_for(path: 'campaigns/sample')
      post_request(url, body: { id: id }).body['data']
    end

    def approve(id:)
      url = url_for(path: 'campaigns/approve')
      post_request(url, body: { id: id }).body['success']
    end

    def delete(id:)
      url = url_for(path: 'campaigns/delete')
      post_request(url, body: { id: id }).body['success']
    end

    def book(id:, **options)
      url = url_for(path: 'campaigns/book')
      post_request(url, body: { id: id }.merge(options)).body['success']
    end
  end
end
