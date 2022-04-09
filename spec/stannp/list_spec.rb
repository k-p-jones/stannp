# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Stannp::List do
  describe '#from_request' do
    it 'creates an array of the supplied object type' do
      data = [{ name: 'Bob' }, { name: 'Sue' }]
      list = described_class.from_request(data: data, type: Stannp::User)
      expect(list.data.length).to eql(2)
      expect(list.data.map(&:class).uniq).to eql([Stannp::User])
      expect(list.data.first.name).to eql('Bob')
      expect(list.data.last.name).to eql('Sue')
    end
  end
end
