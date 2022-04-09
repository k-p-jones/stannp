# frozen_string_literal: true

require 'spec_helper'
require 'faraday'

RSpec.describe Stannp::RecipientsResource do
  let(:api_key) { 'test' }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:client) { Stannp::Client.new(api_key: api_key, adapter: :test, stubs: stubs) }

  describe '#list' do
    context 'with a successful request' do
      let(:response_code) { 200 }
      let(:body) do
        json_response(
          {
            data: [{ id: 1, name: 'Bob Smith' }, { id: 2, name: 'Jane Smith' }]
          }
        )
      end

      context 'without a group_id' do
        before(:each) do
          stubs.get("https://dash.stannp.com/api/v1/recipients/list?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
        end

        it 'returns a list of recipients' do
          list = client.recipients.list
          data = list.data

          expect(list.class).to eql(Stannp::List)
          expect(data.length).to eql(2)

          bob = data.first
          expect(bob.class).to eql(Stannp::Recipient)
          expect(bob.id).to eql(1)
          expect(bob.name).to eql('Bob Smith')

          jane = data.last
          expect(jane.class).to eql(Stannp::Recipient)
          expect(jane.id).to eql(2)
          expect(jane.name).to eql('Jane Smith')
        end
      end

      context 'with a group_id' do
        before(:each) do
          stubs.get("https://dash.stannp.com/api/v1/recipients/list/1234?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
        end
  
        before(:each) do
          stubs.get("https://dash.stannp.com/api/v1/recipients/list?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
        end

        it 'returns a list of recipients' do
          list = client.recipients.list(group_id: 1234)
          data = list.data

          expect(list.class).to eql(Stannp::List)
          expect(data.length).to eql(2)

          bob = data.first
          expect(bob.class).to eql(Stannp::Recipient)
          expect(bob.id).to eql(1)
          expect(bob.name).to eql('Bob Smith')

          jane = data.last
          expect(jane.class).to eql(Stannp::Recipient)
          expect(jane.id).to eql(2)
          expect(jane.name).to eql('Jane Smith')
        end
      end
    end

    context 'with a failing request' do
      let(:response_code) { 500 }
      let(:body) { json_response({ error: 'Boom!' }) }
  
      before(:each) do
        stubs.get("https://dash.stannp.com/api/v1/recipients/list?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
      end
  
      it 'returns an error' do
        expect { client.recipients.list }.to raise_error(Stannp::Error, '500: Boom!')
      end
    end
  
  end

  describe '#get' do
    context 'with a successful request' do
      let(:response_code) { 200 }
      let(:body) do
        json_response({ data: { id: 1, name: 'Bob Smith' } })
      end

      before(:each) do
        stubs.get("https://dash.stannp.com/api/v1/recipients/get/1?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
      end

      it 'returns a recipient' do
        recipient = client.recipients.get(id: 1)
        expect(recipient.class).to eql(Stannp::Recipient)
        expect(recipient.id).to eql(1)
        expect(recipient.name).to eql('Bob Smith')
      end
    end

    context 'with a failing request' do
      let(:response_code) { 500 }
      let(:body) { json_response({ error: 'Boom!' }) }
  
      before(:each) do
        stubs.get("https://dash.stannp.com/api/v1/recipients/get/1?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
      end
  
      it 'returns an error' do
        expect { client.recipients.get(id: 1) }.to raise_error(Stannp::Error, '500: Boom!')
      end
    end
  end
end
