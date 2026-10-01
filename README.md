# mongoid-arraylist

[![CI RSpec Test](https://github.com/joe1chen/mongoid-arraylist/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/joe1chen/mongoid-arraylist/actions/workflows/test.yml)

Edit **Mongoid** `Array` fields as a comma-separated string. `list_field :tags` adds a `tags_list` getter and a
`tags_list=` setter to the model, so a plain text field in a form (`f.text_field :tags_list`) reads and writes the
array — no custom form or controller code needed.

This is the [DOGOnews](https://www.dogonews.com)-maintained fork of
[ismaild/mongoid-arraylist](https://github.com/ismaild/mongoid-arraylist) (upstream has been inactive since 2017;
its last RubyGems release is 0.0.2 from 2013). It is kept working on current Ruby, Rails, Mongoid and MongoDB
versions.

## Supported versions

Tested on every push by the [GitHub Actions matrix](https://github.com/joe1chen/mongoid-arraylist/actions/workflows/test.yml)
([workflow](.github/workflows/test.yml)):

| Ruby | Rails | Mongoid | MongoDB |
|---|---|---|---|
| 2.7 | 6.1 | 7.5 | 6.0 |
| 3.0 | 6.1 | 8.0 | 6.0 |
| 3.1 | 7.0 | 8.1 | 7.0 |
| 3.2 | 7.1 | 8.1 | 7.0 |
| 3.2 | 7.2 | 9.0 | 7.0 |
| 3.3 | 7.2 | 9.0 | 8.0 |
| 3.4 | 8.0 | 9.0 | 8.0 |

The gemspec allows `mongoid >= 7.0, < 10`.

## Installation

This fork is not published to RubyGems; install it from GitHub, pinned to a release tag
([releases](https://github.com/joe1chen/mongoid-arraylist/releases)). The library file is `arraylist`, not the
gem name, so Bundler needs `require:`:

```ruby
# Gemfile
gem 'mongoid-arraylist', github: 'joe1chen/mongoid-arraylist', tag: 'v0.1.0', require: 'arraylist'
```

Then `bundle install`. (Without `require:`, add `require 'arraylist'` before your models load.)

## Usage

```ruby
class Post
  include Mongoid::Document
  include Mongoid::ArrayList

  field :tags, type: Array, default: []

  list_field :tags
end

post = Post.new
post.tags_list = 'tag1, tag2 ,tag3'
post.tags       # => ["tag1", "tag2", "tag3"]
post.tags_list  # => "tag1, tag2, tag3"
```

`list_field <field>` defines, for an existing field:

| Method | Behaviour |
|---|---|
| `<field>_list` | The array joined with `", "`; `nil` when the field is `nil` |
| `<field>_list=(string)` | Splits on `,`, strips whitespace from each item and assigns the array to `<field>` |

In a form:

```erb
<%= f.label :tags_list %>
<%= f.text_field :tags_list %>
```

Remember to permit `:tags_list` (not `:tags`) in strong parameters.

## Development

```bash
# needs a MongoDB on localhost:27017 (e.g. docker run -p 27017:27017 mongo:8.0)
MONGOID_VERSION=9.0 RAILS_VERSION=8.0 bundle install
MONGOID_VERSION=9.0 RAILS_VERSION=8.0 bundle exec rspec spec
```

`MONGOID_VERSION` and `RAILS_VERSION` select the versions in the `Gemfile` (defaults: Mongoid 7.5, Rails 6.1).
To add a combination to CI, add a row to `matrix.include` in `.github/workflows/test.yml`.

## Known issues

- `<field>_list=` calls `split` on its argument, so assigning `nil` raises `NoMethodError`; assign `''` to clear.
- Empty items are kept: `'a,,b'` becomes `["a", "", "b"]`.

## History

Ismail Dhorat's original (2013, released to RubyGems as 0.0.1 and 0.0.2) was continued by DOGOnews in this fork:
0.0.3 (2014–2018: items no longer titlecased, nil-safe getter, Mongoid 2–6), then 0.1.0 (2026: Mongoid 7.0–9.x
on current Ruby/Rails/MongoDB, tested by a GitHub Actions matrix).
See [CHANGELOG.md](CHANGELOG.md).

## Credits

- Ismail Dhorat — original author
- [Contributors](https://github.com/joe1chen/mongoid-arraylist/graphs/contributors)

Copyright (c) 2013 Ismail Dhorat. Licensed under the MIT license (see [LICENSE.txt](LICENSE.txt)).
