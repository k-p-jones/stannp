# frozen_string_literal: true

require 'spec_helper'
require 'faraday'

RSpec.describe Stannp::CampaignsResource do
  let(:api_key)       { 'test' }
  let(:stubs)         { Faraday::Adapter::Test::Stubs.new }
  let(:client)        { Stannp::Client.new(api_key: api_key, adapter: :test, stubs: stubs) }
  let(:response_code) { 200 }


  describe '#list' do
    let(:body) do
      json_response({ data: [{ id: 1, name: 'Summer Campaign' }, { id: 2, name: 'Winter Campaign' }] })
    end

    before(:each) do
      stubs.get("https://dash.stannp.com/api/v1/campaigns/list?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
    end

    it 'returns a list of campaigns' do
      list = client.campaigns.list
      data = list.data
      expect(list.class).to eql(Stannp::List)
      expect(data.length).to eql(2)
      expect(data.map(&:class).uniq).to eql([Stannp::Campaign])
      expect(data.first.id).to eql(1)
      expect(data.first.name).to eql('Summer Campaign')
      expect(data.last.id).to eql(2)
      expect(data.last.name).to eql('Winter Campaign')
    end
  end

  describe '#get' do
    let(:body) do
      json_response({ data: { id: 1, name: 'Summer Campaign' } })
    end

    before(:each) do
      stubs.get("https://dash.stannp.com/api/v1/campaigns/get/1?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
    end

    it 'returns a single campaign' do
      campaign = client.campaigns.get(id: 1)
      expect(campaign.class).to eql(Stannp::Campaign)
      expect(campaign.id).to eql(1)
      expect(campaign.name).to eql('Summer Campaign')
    end
  end

  describe '#cost' do
    let(:url) { "https://dash.stannp.com/api/v1/campaigns/cost?api_key=#{client.api_key}" }
    let(:body) do
      json_response({ data: { total: '0.84' } })
    end

    before(:each) do
      stubs.post(url, { id: 1 }.to_json) { |_| [response_code, {}, body] }
    end

    it 'returns the campaign cost' do
      cost = client.campaigns.cost(id: 1)
      expect(cost.class).to eql(Stannp::CampaignCost)
      expect(cost.total).to eql('0.84')
    end
  end

  describe '#available_booking_dates' do
    let(:url) { "https://dash.stannp.com/api/v1/campaigns/availableDates?api_key=#{client.api_key}" }
    let(:body) do
      json_response({ data: ['2022-01-01', '2022-01-02'] })
    end

    before(:each) do
      stubs.post(url, { start: '2022-1-1', end: '2022-1-3' }.to_json) { |_| [response_code, {}, body] }
    end

    it 'returns an array of the available dats as strings' do
      expect(client.campaigns.available_booking_dates(start_date: '2022-1-1', end_date: '2022-1-3'))
        .to match_array(['2022-01-01', '2022-01-02'])
    end
  end

  describe '#create' do
    let(:url) { "https://dash.stannp.com/api/v1/campaigns/create?api_key=#{client.api_key}" }
    let(:body) do
      json_response({ data: 12 })
    end
  
    before(:each) do
      stubs.post(url, { name: 'Test Campaign', template_id: '1234' }.to_json) { |_| [response_code, {}, body] }
    end

    it 'returns a campaign' do
      params = { name: 'Test Campaign', template_id: '1234' }
      campaign = client.campaigns.create(attributes: params)
      expect(campaign.class).to eql(Stannp::Campaign)
      expect(campaign.id).to eql(12)
    end
  end

  describe '#sample_url' do
    let(:url) { "https://dash.stannp.com/api/v1/campaigns/sample?api_key=#{client.api_key}" }
    let(:body) do
      json_response({ data: 'https://stannp.com/path/to/sample.pdf' })
    end

    before(:each) do
      stubs.post(url, { id: 1 }.to_json) { |_| [response_code, {}, body] }
    end

    it 'returns the url of the sample pdf' do
      expect(client.campaigns.sample_url(id: 1)).to eql('https://stannp.com/path/to/sample.pdf')
    end
  end

  describe '#approve' do
    let(:url) { "https://dash.stannp.com/api/v1/campaigns/approve?api_key=#{client.api_key}" }
    let(:body) do
      json_response({ success: true })
    end

    before(:each) do
      stubs.post(url, { id: 1 }.to_json) { |_| [response_code, {}, body] }
    end

    it 'returns true' do
      expect(client.campaigns.approve(id: 1)).to eql(true)
    end
  end

  describe '#delete' do
    let(:url) { "https://dash.stannp.com/api/v1/campaigns/delete?api_key=#{client.api_key}" }
    let(:body) do
      json_response({ success: true })
    end

    before(:each) do
      stubs.post(url, { id: 1 }.to_json) { |_| [response_code, {}, body] }
    end

    it 'returns true' do
      expect(client.campaigns.delete(id: 1)).to eql(true)
    end
  end

  describe '#book' do
    let(:url) { "https://dash.stannp.com/api/v1/campaigns/book?api_key=#{client.api_key}" }
    let(:body) do
      json_response({ success: true })
    end

    before(:each) do
      stubs.post(url, { id: 1, send_date: '2022-1-1', use_balance: false }.to_json) { |_| [response_code, {}, body] }
    end

    it 'returns true' do
      expect(client.campaigns.book(id: 1, send_date: '2022-1-1', use_balance: false)).to eql(true)
    end
  end
end
