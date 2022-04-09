# frozen_string_literal: true

require 'spec_helper'
require 'faraday'

RSpec.describe Stannp::AccountResource do
  let(:api_key) { 'test' }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:client) { Stannp::Client.new(api_key: api_key, adapter: :test, stubs: stubs) }

  before(:each) do
    stubs.get("https://dash.stannp.com/api/v1/accounts/balance?api_key=#{client.api_key}}") { |_| [response_code, {}, body] }
  end

  context 'with a successful request' do
    let(:response_code) { 200 }
    let(:body) { json_response({ data: { balance: '100.59' } }) }

    it 'returns the account balance' do
      expect(client.account.balance).to eql('100.59')
    end
  end

  context 'with a failing request' do
    let(:response_code) { 500 }
    let(:body) { json_response({ error: 'Server says no!' }) }

    it 'returns an error' do
      expect { client.account.balance }.to raise_error(Stannp::Error, '500: Server says no!')
    end
  end
end
