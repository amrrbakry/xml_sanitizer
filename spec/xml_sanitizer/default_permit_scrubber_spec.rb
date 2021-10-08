# frozen_string_literal: true

RSpec.describe XmlSanitizer::DefaultPermitScrubber do
  subject(:scrubber) { described_class.new }

  describe '#node_name' do
    context 'with namespace' do
      let(:node) { instance_double(Nokogiri::XML::Node, name: 'bar', namespace: namespace) }
      let(:namespace) { instance_double(Nokogiri::XML::Namespace, prefix: 'foo') }

      it 'returns the correct node name' do
        expect(scrubber.node_name(node)).to eq('foo:bar')
      end
    end

    context 'without namespace' do
      let(:node) { instance_double(Nokogiri::XML::Node, name: 'foobar', namespace: nil) }

      it 'returns the correct node name' do
        expect(scrubber.node_name(node)).to eq('foobar')
      end
    end
  end

  describe '#namespace_prefix?' do
    context 'with namespace' do
      let(:node) { instance_double(Nokogiri::XML::Node, name: 'bar', namespace: namespace) }
      let(:namespace) { instance_double(Nokogiri::XML::Namespace, prefix: 'foo') }

      it 'returns true' do
        expect(scrubber.namespace_prefix?(node)).to be true
      end
    end

    context 'without namespace' do
      let(:node) { instance_double(Nokogiri::XML::Node, name: 'foobar', namespace: nil) }

      it 'returns false' do
        expect(scrubber.namespace_prefix?(node)).to be false
      end
    end
  end

  describe '#node_name_with_namespace_prefix' do
    let(:node) { instance_double(Nokogiri::XML::Node, name: 'bar', namespace: namespace) }
    let(:namespace) { instance_double(Nokogiri::XML::Namespace, prefix: 'foo') }

    it 'returns the correct node name with namespace prefix' do
      expect(scrubber.node_name_with_namespace_prefix(node)).to eq('foo:bar')
    end
  end
end
