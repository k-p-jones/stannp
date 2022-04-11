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

    let(:response_code) { 200 }
    let(:body) { json_response({ data: { name: 'Foo' } }) }

    it 'returns the user' do
      user = client.user.get
      expect(user.class).to eql(Stannp::User)
      expect(user.name).to eql('Foo')
    end
  end
end
