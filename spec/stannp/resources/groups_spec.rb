# frozen_string_literal: true

require 'spec_helper'
require 'faraday'

RSpec.describe Stannp::GroupsResource do
  let(:api_key) { 'test' }
  let(:stubs)   { Faraday::Adapter::Test::Stubs.new }
  let(:client)  { Stannp::Client.new(api_key: api_key, adapter: :test, stubs: stubs) }

  describe '#list' do
    context 'with an offset and limit' do
      let(:response_code) { 200 }
      let(:body) do
        json_response({ data: [{ id: 1, name: 'Summer' }, { id: 2, name: 'Winter' }] })
      end

      before(:each) do
        stubs.get("https://dash.stannp.com/api/v1/groups/list?api_key=#{client.api_key}&offset=1&limit=1") { |_| [response_code, {}, body] }
      end

      it 'returns a list of groups' do
        list = client.groups.list(offset: 1, limit: 1)
        data = list.data
        expect(list.class).to eql(Stannp::List)
        expect(data.length).to eql(2)
        expect(data.map(&:class).uniq).to eql([Stannp::Group])
        expect(data.first.id).to eql(1)
        expect(data.first.name).to eql('Summer')
        expect(data.last.id).to eql(2)
        expect(data.last.name).to eql('Winter')
      end
    end

    context 'without an offset and limit' do
      let(:response_code) { 200 }
      let(:body) do
        json_response({ data: [{ id: 1, name: 'Summer' }, { id: 2, name: 'Winter' }] })
      end

      before(:each) do
        stubs.get("https://dash.stannp.com/api/v1/groups/list?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
      end

      it 'returns a list of groups' do
        list = client.groups.list
        data = list.data
        expect(list.class).to eql(Stannp::List)
        expect(data.length).to eql(2)
        expect(data.map(&:class).uniq).to eql([Stannp::Group])
        expect(data.first.id).to eql(1)
        expect(data.first.name).to eql('Summer')
        expect(data.last.id).to eql(2)
        expect(data.last.name).to eql('Winter')
      end
    end
  end

  describe '#create' do
    let(:response_code) { 200 }
    let(:body) do
      json_response({ data: { id: 1, name: 'Summer' } })
    end

    before(:each) do
      stubs.post("https://dash.stannp.com/api/v1/groups/new?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
    end

    it 'creates a group' do
      group = client.groups.create(name: 'Summer')
      expect(group.class).to eql(Stannp::Group)
      expect(group.id).to eql(1)
      expect(group.name).to eql('Summer')
    end
  end

  describe '#delete' do
    let(:response_code) { 200 }
    let(:body) do
      json_response(success: true)
    end

    before(:each) do
      stubs.post("https://dash.stannp.com/api/v1/groups/delete/1?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
    end

    it 'returns true' do
      expect(client.groups.delete(id: 1)).to eql(true)
    end  
  end

  describe '#purge' do
    let(:response_code) { 200 }
    let(:body) do
      json_response(success: true)
    end

    before(:each) do
      stubs.post("https://dash.stannp.com/api/v1/groups/purge/1?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
    end

    it 'returns true' do
      expect(client.groups.purge(id: 1, delete_recipients: true)).to eql(true)
    end
  end

  describe '#add_recipients' do
    let(:url) { "https://dash.stannp.com/api/v1/groups/add/1?api_key=#{client.api_key}" }
    let(:response_code) { 200 }
    let(:body) do
      json_response(success: true)
    end

    before(:each) do
      stubs.post(url, { recipients: '1,2,3' }.to_json) { |_| [response_code, {}, body] }
    end

    context 'with an array' do
      it 'returns true' do
        expect(client.groups.add_recipients(id: 1, recipient_ids: [1, 2, 3])).to eql(true)
      end
    end

    context 'with a comma separated string' do
      it 'returns true' do
        expect(client.groups.add_recipients(id: 1, recipient_ids: '1,2,3')).to eql(true)
      end
    end
  end

  describe '#remove_recipients' do
    let(:url) { "https://dash.stannp.com/api/v1/groups/remove/1?api_key=#{client.api_key}" }
    let(:response_code) { 200 }
    let(:body) do
      json_response(success: true)
    end

    before(:each) do
      stubs.post(url, { recipients: '1,2,3' }.to_json) { |_| [response_code, {}, body] }
    end

    context 'with an array' do
      it 'returns true' do
        expect(client.groups.remove_recipients(id: 1, recipient_ids: [1, 2, 3])).to eql(true)
      end
    end

    context 'with a comma separated string' do
      it 'returns true' do
        expect(client.groups.remove_recipients(id: 1, recipient_ids: '1,2,3')).to eql(true)
      end
    end
  end
end
