# frozen_string_literal: true

require 'spec_helper'
require 'faraday'

RSpec.describe Stannp::AccountResource do
  let(:api_key) { 'test' }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:client) { Stannp::Client.new(api_key: api_key, adapter: :test, stubs: stubs) }

  describe '#balance' do
    before(:each) do
      stubs.get("https://dash.stannp.com/api/v1/accounts/balance?api_key=#{client.api_key}}") { |_| [response_code, {}, body] }
    end

    let(:response_code) { 200 }
    let(:body) { json_response({ data: { balance: '100.59' } }) }

    it 'returns the account balance' do
      expect(client.account.balance).to eql('100.59')
    end
  end

  describe '#top_up' do
    before(:each) do
      stubs.post("https://dash.stannp.com/api/v1/accounts/topup?api_key=#{client.api_key}}") { |_| [response_code, {}, body] }
    end

    let(:response_code) { 200 }
    let(:body) { json_response({ data: { receipt_pdf: '/path/to/pdf' } }) }

    it 'returns a receipt' do
      receipt = client.account.top_up(amount: 10)
      expect(receipt.class).to eql(Stannp::Receipt)
      expect(receipt.url).to eql('/path/to/pdf')
    end
  end
end
