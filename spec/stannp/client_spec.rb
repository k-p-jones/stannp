# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Stannp::Client do
  it 'exposes the API key' do
    expect(described_class.new(api_key: '12346').api_key).to eql('12346')
  end
end
