# frozen_string_literal: true

module XmlSanitizer
  class DefaultPermitScrubber < Loofah::Scrubber
    attr_accessor :direction, :permit_tags

    def initialize(permit_tags: [])
      super
      @permit_tags = permit_tags
    end

    def scrub(node)
      return CONTINUE if skip_node?(node)

      node.remove unless allowed_node?(node)
    end

    def node_name(node)
      namespace_prefix?(node) ? node_name_with_namespace_prefix(node) : node.name
    end

    def namespace_prefix?(node)
      node&.namespace&.prefix
    end

    def node_name_with_namespace_prefix(node)
      "#{node.namespace.prefix}:#{node.name}"
    end

    protected

    def allowed_node?(node)
      permit_tags.include?(node_name(node))
    end

    def skip_node?(node)
      !node.element?
    end
  end
end
