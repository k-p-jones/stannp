# frozen_string_literal: true

require 'spec_helper'
require 'faraday'

RSpec.describe Stannp::EventsResource do
  let(:api_key) { 'test' }
  let(:stubs)   { Faraday::Adapter::Test::Stubs.new }
  let(:client)  { Stannp::Client.new(api_key: api_key, adapter: :test, stubs: stubs) }

  describe '#create' do
    let(:response_code) { 200 }
    let(:body) do
      json_response({ data: 366, success: true })
    end

    before(:each) do
      stubs.post("https://dash.stannp.com/api/v1/recipientEvents/create?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
    end

    it 'returns the ID of the event' do
      attrs = { recipient_id: '1234', ref: '1234', name: 'PURCHASE' }
      result = client.events.create(attributes: attrs)
      expect(result).to eql(366)
    end
  end
end
