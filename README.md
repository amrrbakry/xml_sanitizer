# XmlSanitizer

XML sanitization with [Loofah](https://github.com/flavorjones/loofah) and [Nokogiri](https://github.com/sparklemotion/nokogiri).

```ruby
scrubber = XmlSanitizer::DefaultPermitScrubber.new
scrubber.tags = ["foo", "bar"]

xml = '<foo><bar><baz>baz</baz></bar></foo>'

XmlSanitizer.sanitize(xml: xml, scrubber: scrubber) # or use your custom scrubber
# => "<?xml version=\"1.0\"?>\n<foo>\n  <bar/>\n</foo>\n"
```

The default scrubber will remove all non-permitted tags and their subtrees.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xml_sanitizer'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install xml_sanitizer

## Usage

### Sanitize an XML document
```ruby
scrubber = XmlSanitizer::DefaultPermitScrubber.new
scrubber.tags = ["foo"]
scrubber.direction = :bottom_up # default is :top_down

xml = '<foo><bar><baz>baz</baz></bar></foo>'

XmlSanitizer.sanitize(xml: xml, scrubber: scrubber)
# => "<?xml version=\"1.0\"?>\n<foo/>\n"
```

#### with XML namespaces

```ruby
scrubber = XmlSanitizer::DefaultPermitScrubber.new
scrubber.tags = ["ns:foo"]

xml = '<ns:foo xmlns:ns="http://www.w3.org/TR/html4/"><bar>baz</bar></ns:foo>'

XmlSanitizer.sanitize(xml: xml, scrubber: scrubber)
# => "<?xml version=\"1.0\"?>\n<ns:foo xmlns:ns=\"http://www.w3.org/TR/html4/\"/>\n"
 ```

### Sanitize an XML fragment
```ruby
scrubber = XmlSanitizer::DefaultPermitScrubber.new(tags: %w[foo bar])
xml = '<foo><bar>baz</bar></foo>'

XmlSanitizer.sanitize_fragment(xml: xml, scrubber: scrubber)
# => "<foo>\n  <bar>baz</bar>\n</foo>"
 ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/amrrbakry/xml_sanitizer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/amrrbakry/xml_sanitizer/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the XmlSanitizer project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/amrrbakry/xml_sanitizer/blob/master/CODE_OF_CONDUCT.md).
