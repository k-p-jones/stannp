# frozen_string_literal: true

require 'spec_helper'
require 'faraday'

RSpec.describe Stannp::Resource do
  let(:api_key) { 'test' }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:client) { Stannp::Client.new(api_key: api_key, adapter: :test, stubs: stubs) }
  let(:resource) { Stannp::Resource.new(client: client) }

  describe '#get_request' do
    let(:url) { "https://dash.stannp.com/api/v1/users/me?api_key=#{api_key}" }

    context 'with a successful request' do
      let(:response_code) { 200 }
      let(:body)          { json_response({ success: true }) }

      before(:each) do
        stubs.get(url) { |_| [response_code, {}, body] }
      end
  
      it 'returns the correct rrsponse' do
        response = resource.get_request(url)
        expect(response.body).to eql(body)
      end
    end

    context 'with a failing request' do
      let(:response_code) { 400 }
      let(:body)          { json_response({ error: 'Oh No!' }) }
      let(:url)           { "https://dash.stannp.com/api/v1/users/me?api_key=#{api_key}" }

      before(:each) do
        stubs.get(url) { |_| [response_code, {}, body] }
      end
  
      it 'raises an error' do
        expect{ resource.get_request(url) }.to raise_error(Stannp::Error, '400: Oh No!')
      end
    end
  end

  describe '#post_request' do
    let(:url) { "https://dash.stannp.com/api/v1/users/me?api_key=#{api_key}" }

    context 'with a successful request' do
      let(:response_code) { 200 }
      let(:body)          { json_response({ success: true }) }

      before(:each) do
        stubs.post(url) { |_| [response_code, {}, body] }
      end
  
      it 'returns the correct rrsponse' do
        response = resource.post_request(url, body: { id: 1 })
        expect(response.body).to eql(body)
      end
    end

    context 'with a failing request' do
      let(:response_code) { 400 }
      let(:body)          { json_response({ error: 'Oh No!' }) }
      let(:url)           { "https://dash.stannp.com/api/v1/users/me?api_key=#{api_key}" }

      before(:each) do
        stubs.post(url) { |_| [response_code, {}, body] }
      end
  
      it 'raises an error' do
        expect{ resource.post_request(url, body: { id: 1 }) }.to raise_error(Stannp::Error, '400: Oh No!')
      end
    end
  end
end
