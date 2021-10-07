# frozen_string_literal: true

require_relative 'lib/xml_sanitizer/version'

Gem::Specification.new do |spec|
  spec.name          = 'xml_sanitizer'
  spec.version       = XmlSanitizer::VERSION
  spec.authors       = ['Amr El Bakry']
  spec.email         = ['amrr@hey.com']

  spec.summary       = 'XML sanitization with Loofah and Nokogiri.'
  spec.homepage      = 'https://github.com/amrrbakry/xml_sanitizer'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata['homepage_uri'] = 'https://github.com/amrrbakry/xml_sanitizer'
  spec.metadata['source_code_uri'] = 'https://github.com/amrrbakry/xml_sanitizer'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'loofah', '~> 2.12'

  spec.add_development_dependency 'byebug', '~> 11.0'
end
