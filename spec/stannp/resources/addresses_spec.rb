# frozen_string_literal: true

require 'spec_helper'
require 'faraday'

RSpec.describe Stannp::AddressesResource do
  let(:api_key) { 'test' }
  let(:stubs)   { Faraday::Adapter::Test::Stubs.new }
  let(:client)  { Stannp::Client.new(api_key: api_key, adapter: :test, stubs: stubs) }

  describe '#validate' do
    let(:response_code) { 200 }
    let(:body)          { json_response({ data: { is_valid: true } }) }

    before(:each) do
      stubs.post("https://dash.stannp.com/api/v1/addresses/validate?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
    end

    it 'returns the correct response' do
      expect(client.addresses.validate(attributes: { address1: 'A house' })).to eql(true)
    end
  end
end
