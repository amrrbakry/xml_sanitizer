# frozen_string_literal: true

require 'loofah'
require_relative 'xml_sanitizer/version'
require_relative 'xml_sanitizer/default_permit_scrubber'

module XmlSanitizer
  class << self
    def sanitize(xml:, scrubber: DefaultPermitScrubber.new)
      xml_document = Loofah.xml_document(xml)

      xml_document.scrub!(scrubber)
      xml_document.to_xml
    end

    alias sanitize_document sanitize

    def sanitize_fragment(xml:, scrubber: DefaultPermitScrubber.new)
      xml_fragment = Loofah.xml_fragment(xml)

      xml_fragment.scrub!(scrubber)
      xml_fragment.to_xml
    end
  end
end
