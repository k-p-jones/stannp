# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Stannp::Object do
  it 'creates an object from a hash' do
    obj = described_class.new(foo: 'bar')
    expect(obj.foo).to eql('bar')
    expect(obj.respond_to?(:foo)).to eql(true)
  end

  it 'creates an object from a nested hash' do
    obj = described_class.new(foo: 'bar', bar: { this: 'that' })
    expect(obj.foo).to eql('bar')
    expect(obj.bar.this).to eql('that')
    expect(obj.bar.respond_to?(:this)).to eql(true)
  end

  it 'transforms objects in arrays/nested arrays correctly' do
    obj = described_class.new(foo: [{ bar: 'baz', baz: [{ bar: 34 }] }], bar: [12])
    expect(obj.foo.first.bar).to eql('baz')
    expect(obj.bar.first).to eql(12)
    expect(obj.foo.first.baz.first.bar).to eql(34)
  end
end
