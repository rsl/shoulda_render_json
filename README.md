# Shoulda RenderJson [![Code Climate](https://codeclimate.com/github/rsl/shoulda_render_json.png)](https://codeclimate.com/github/rsl/shoulda_render_json) [![Gem Version](https://badge.fury.io/rb/shoulda_render_json.svg)](http://badge.fury.io/rb/shoulda_render_json)

Shoulda macros for making very basic assertions about JSON responses

## Installation

Add this line to your application's Gemfile:

    gem 'shoulda_render_json', group: :test

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shoulda_render_json

## Usage

I'm going to presume you're already familiar with using Shoulda macros.
The most basic assertion for `render_json` will be that your response's content-type is
'application/json' (Rails' default JSON content-type) and that there is a root-level node
named "foo" in the JSON.

```ruby
should render_json('foo')
```

Voilà! That's probably not too useful on its own though. Let's add some child node checks!

```ruby
should render_json('foo', required: 'bar', forbidden: 'baz')
```

Predictably this adds two additional assertions to that base assertion. First, that the node for
"foo" is required to have a child node named "bar". Second, that the node for "foo" is prohibited
from having a child node named "baz". Both of these values can be arrays as well as strings as seen
below.

```ruby
should render_json('foo', required: %w{bar baz})
```

Sometimes, you may need to make assertions on Arrays inside JSON responses and not just Hash/Objects.
I've got you covered there too.

```ruby
should render_json('foo', type: Array)
```

If you need to make assertions on the members of that Array, you can use the same `required` and
`forbidden` options but be aware these assertions will be expected to be true for *every* member
of the Array. If you've got members that violate this, you'll probably be better off writing custom
assertions anyhow.

That's it!

## TODO

1. Test coverage. I've extracted this from one of my own test suites so there's no tests.

## Contributing

1. Fork it ( https://github.com/rsl/shoulda_render_json/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
