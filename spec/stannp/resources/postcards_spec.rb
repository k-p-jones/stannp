# frozen_string_literal: true

require 'spec_helper'
require 'faraday'

RSpec.describe Stannp::PostcardsResource do
  let(:api_key) { 'test' }
  let(:stubs)   { Faraday::Adapter::Test::Stubs.new }
  let(:client)  { Stannp::Client.new(api_key: api_key, adapter: :test, stubs: stubs) }

  describe '#get' do
    let(:response_code) { 200 }
    let(:body)          { json_response({ data: { id: 1, type: 'postcard' } }) }

    before(:each) do
      stubs.get("https://dash.stannp.com/api/v1/postcards/get/1?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
    end

    it 'returns a postcard' do
      card = client.postcards.get(id: '1')
      expect(card.class).to eql(Stannp::Postcard)
      expect(card.id).to eql(1)
      expect(card.type).to eql('postcard')
    end
  end

  describe '#create' do
    let(:response_code) { 200 }
    let(:body)          { json_response({ data: { id: 1, type: 'postcard' } }) }
  
    before(:each) do
      stubs.post("https://dash.stannp.com/api/v1/postcards/create?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
    end

    it 'creates a postcard' do
      body = {
        recipient: 1234,
        template: 1345,
        size: 'A6'
      }
      card = client.postcards.create(attributes: body)
      expect(card.class).to eql(Stannp::Postcard)
      expect(card.id).to eql(1)
      expect(card.type).to eql('postcard')
    end
  end

  describe '#cancel' do
    let(:response_code) { 200 }
    let(:body)          { json_response({ success: true }) }

    before(:each) do
      stubs.post("https://dash.stannp.com/api/v1/postcards/cancel?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
    end

    it 'cancels a postcard' do
      expect(client.postcards.cancel(id: '1')).to eql(true)
    end
  end
end
