# Crest

A contact card your Rails app hands out, so a text from an unknown number arrives under a name.

`GET /houseaccount.vcf` answers with a vCard. A phone offers to save it, and from then on your
messages come from *HouseAccount* rather than from `774-468-7322`.

## How to install

```sh
gem install crest
```

Or, in your `Gemfile`:

```ruby
gem 'crest', '~> 1.0'
```

`~> major.minor` is what makes that safe: `bundle update` takes every fix and every feature
Crest ships, and never crosses a breaking change, because the major only moves when the API
does — and from `1.0` on it moves only on purpose.

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

The picture is bytes, or a path the gem reads, read afresh for each card, so replacing the file
replaces the picture. PNG and JPEG are told apart by the image's own first bytes rather than by
anything you have to declare, and anything else is warned about on stderr and left off the card
— a public route is the wrong place to discover that somebody swapped a file.

**The card is an organization's.** `N:` carries the one name a business has, which is why `name`
is a single setting. A person's card wants a given name and a family name in their own fields,
and Crest does not take them.

## Without Rails

The builder is plain Ruby and loads on its own, Rails or no Rails:

```ruby
require 'crest/card'

Crest::Card.new(name: 'HouseAccount', phone: '+17744687322',
                url: 'https://houseaccount.com/', photo: 'cube.png').to_s
```

It answers a vCard 3.0 string, CRLF-delimited and folded at 74 characters with the continuation
space the format asks for.

## Documentation

The API reference is at [rubydoc.info/gems/crest](https://rubydoc.info/gems/crest).

## License

MIT, see [LICENSE.txt](LICENSE.txt).
