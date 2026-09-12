# Crest

A contact card your Rails app hands out, so a text from an unknown number arrives under a name.

`GET /houseaccount.vcf` answers with a vCard. A phone offers to save it, and from then on your
messages come from *HouseAccount* rather than from `+1 800 555 0100`.

## How to install

```sh
gem install crest
```

Or, in your `Gemfile`:

```ruby
gem 'crest', '~> 0.1.0'
```

Crest is below `1.0`, so the pin stops short of `0.2.0` rather than admitting every `0.x`:
`~> major.minor` only promises what it says once the major is real. From `1.0` on it will be
`~> 1.0`, and `bundle update` will never cross a breaking change.

## Handing out a card

One line in `config/routes.rb`:

```ruby
crest 'houseaccount.vcf'
```

and one initializer, `config/initializers/crest.rb`:

```ruby
Crest.configure do |config|
  config.name  = 'HouseAccount'
  config.org   = 'HouseAccount'
  config.url   = 'https://houseaccount.com/'
  config.email = 'support@houseaccount.com'
  config.photo = Rails.root.join 'public/cube.png'
  config.phone = -> { Twilio.sender }
end
```

That is the whole of it. The route gives you a `houseaccount_vcf_path` helper to link to, and
the response is `text/vcard`, named after the file, and cacheable.

Only `name` and `phone` are required, and the gem raises rather than handing out a card that
saves under a blank name. Everything else is left out of the card when you do not set it.

**Every setting may be a value or a callable**, and a callable is asked again on every request.
That is what makes a number read out of the environment safe: production and staging differ, and
a value read once at boot would be wrong in one of them until a restart.

The picture is bytes, or a path the gem reads. It is read from disk once, and PNG and JPEG are
told apart by the image's own first bytes rather than by anything you have to declare.

## Without Rails

The builder is plain Ruby and loads on its own, Rails or no Rails:

```ruby
require 'crest/card'

Crest::Card.new(name: 'HouseAccount', phone: '+18005550100',
                url: 'https://houseaccount.com/', photo: 'cube.png').to_s
```

It answers a vCard 3.0 string, CRLF-delimited and folded at 74 characters with the continuation
space the format asks for.

## Documentation

The API reference is at [rubydoc.info/gems/crest](https://rubydoc.info/gems/crest).

## License

MIT, see [LICENSE.txt](LICENSE.txt).
