# frozen_string_literal: true

require 'spec_helper'
require 'faraday'

RSpec.describe Stannp::LettersResource do
  let(:api_key) { 'test' }
  let(:stubs)   { Faraday::Adapter::Test::Stubs.new }
  let(:client)  { Stannp::Client.new(api_key: api_key, adapter: :test, stubs: stubs) }

  describe '#get' do
    let(:response_code) { 200 }
    let(:body)          { json_response({ data: { id: 1, type: 'letter' } }) }

    before(:each) do
      stubs.get("https://dash.stannp.com/api/v1/letters/get/1?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
    end

    it 'returns a letter' do
      letter = client.letters.get(id: '1')
      expect(letter.class).to eql(Stannp::Letter)
      expect(letter.id).to eql(1)
      expect(letter.type).to eql('letter')
    end
  end

  describe '#create' do
    let(:response_code) { 200 }
    let(:body)          { json_response({ data: { id: 1, type: 'letter' } }) }
  
    before(:each) do
      stubs.post("https://dash.stannp.com/api/v1/letters/create?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
    end

    it 'creates a letter' do
      body = {
        recipient: 1234,
        template: 1345
      }
      letter = client.letters.create(attributes: body)
      expect(letter.class).to eql(Stannp::Letter)
      expect(letter.id).to eql(1)
      expect(letter.type).to eql('letter')
    end
  end

  describe '#cancel' do
    let(:response_code) { 200 }
    let(:body)          { json_response({ success: true }) }

    before(:each) do
      stubs.post("https://dash.stannp.com/api/v1/letters/cancel?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
    end

    it 'cancels a letter' do
      expect(client.letters.cancel(id: '1')).to eql(true)
    end
  end

  describe '#post' do
    let(:response_code) { 200 }
    let(:body)          { json_response({ data: { id: 1, type: 'letter' } }) }

    before(:each) do
      stubs.post("https://dash.stannp.com/api/v1/letters/post?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
    end

    it 'creates a letter' do
      body = { pdf: 'link/to/pdf' }
      letter = client.letters.post(attributes: body)
      expect(letter.class).to eql(Stannp::Letter)
      expect(letter.id).to eql(1)
      expect(letter.type).to eql('letter')
    end
  end

  describe '#batch' do
    let(:response_code) { 200 }
    let(:body)          { json_response({ data: { id: 1, type: 'batch' } }) }

    before(:each) do
      stubs.post("https://dash.stannp.com/api/v1/letters/batch?api_key=#{client.api_key}") { |_| [response_code, {}, body] }
    end

    it 'creates a batch' do
      body = { csv: 'a csv' }
      batch = client.letters.batch(attributes: body)
      expect(batch.class).to eql(Stannp::Batch)
      expect(batch.id).to eql(1)
      expect(batch.type).to eql('batch')
    end
  end
end
