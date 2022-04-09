# frozen_string_literal: true

require 'spec_helper'
require 'faraday'

RSpec.describe Stannp::UserResource do
  describe '#get' do
    let(:api_key) { 'test' }
    let(:stubs) { Faraday::Adapter::Test::Stubs.new }
    let(:client) { Stannp::Client.new(api_key: api_key, adapter: :test, stubs: stubs) }

    before(:each) do
      stubs.get("https://dash.stannp.com/api/v1/users/me?api_key=#{api_key}") { |_| [response_code, {}, body] }
    end

    context 'with a successful request' do
      let(:response_code) { 200 }
      let(:body) { json_response({ data: { name: 'Foo' } }) }

      it 'returns the user' do
        user = client.user.get
        expect(user.class).to eql(Stannp::User)
        expect(user.name).to eql('Foo')
      end
    end

    context 'with an unsuccessful request' do
      let(:response_code) { 403 }
      let(:body) { JSON.parse({ error: 'Bang!' }.to_json) }

      it 'raises an error' do
        expect { client.user.get }.to raise_error(Stannp::Error, '403: Bang!')
      end
    end
  end
end
