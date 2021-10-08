# frozen_string_literal: true

RSpec.describe XmlSanitizer do
  it 'has a version number' do
    expect(XmlSanitizer::VERSION).not_to be nil
  end

  describe '.santize' do
    let(:tags) { %w[foo bar] }
    let(:scrubber) { XmlSanitizer::DefaultPermitScrubber.new(tags: tags) }
    let(:xml) { '<foo><bar>baz</bar></foo>' }

    subject(:sanitizer_result) { XmlSanitizer.sanitize(xml: xml, scrubber: scrubber) }

    it 'returns sanitized xml' do
      expect(sanitizer_result).to eq("<?xml version=\"1.0\"?>\n<foo>\n  <bar>baz</bar>\n</foo>\n")
    end

    context 'with different tags' do
      let(:tags) { %w[foo] }

      it 'returns sanitized xml' do
        expect(sanitizer_result).to eq("<?xml version=\"1.0\"?>\n<foo/>\n")
      end
    end

    context 'when a not allowed tag has a subtree' do
      let(:tags) { %w[foo bar] }
      let(:xml) { '<foo><bar><baz><bad>bad</bad></baz></bar></foo>' }

      it 'removes not allowed tags with their subtree' do
        expect(sanitizer_result).to eq("<?xml version=\"1.0\"?>\n<foo>\n  <bar/>\n</foo>\n")
      end
    end

    context 'with tags with a namespace' do
      let(:tags) { %w[ns:foo] }
      let(:xml) { '<ns:foo xmlns:ns="http://www.w3.org/TR/html4/"><bar>baz</bar></ns:foo>' }

      it 'returns sanitized xml' do
        expect(sanitizer_result).to eq("<?xml version=\"1.0\"?>\n<ns:foo xmlns:ns=\"http://www.w3.org/TR/html4/\"/>\n")
      end
    end
  end

  describe '.sanitize_fragment' do
    let(:tags) { %w[foo bar] }
    let(:scrubber) { XmlSanitizer::DefaultPermitScrubber.new(tags: tags) }
    let(:xml) { '<foo><bar>baz</bar></foo>' }

    subject(:sanitizer_result) { XmlSanitizer.sanitize_fragment(xml: xml, scrubber: scrubber) }

    it 'returns sanitized xml' do
      expect(sanitizer_result).to eq("<foo>\n  <bar>baz</bar>\n</foo>")
    end

    context 'with different tags' do
      let(:tags) { %w[foo] }

      it 'returns sanitized xml' do
        expect(sanitizer_result).to eq('<foo/>')
      end
    end

    context 'when a not allowed tag has a subtree' do
      let(:tags) { %w[foo bar] }
      let(:xml) { '<foo><bar><baz><bad>bad</bad></baz></bar></foo>' }

      it 'removes not allowed tags with their subtree' do
        expect(sanitizer_result).to eq("<foo>\n  <bar/>\n</foo>")
      end
    end

    context 'with tags with a namespace' do
      let(:tags) { %w[ns:foo] }
      let(:xml) { '<ns:foo xmlns:ns="http://www.w3.org/TR/html4/"><bar>baz</bar></ns:foo>' }

      it 'returns sanitized xml' do
        expect(sanitizer_result).to eq('<ns:foo xmlns:ns="http://www.w3.org/TR/html4/"/>')
      end
    end
  end
end
