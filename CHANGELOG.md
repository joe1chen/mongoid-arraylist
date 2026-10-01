# Changelog

All notable changes to this project are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-10-01
DOGOnews fork. Minor version (0.x) because the minimum supported Mongoid rose from none (0.0.3 accepted any version)
to 7.0.

### Added
- GitHub Actions test matrix (`.github/workflows/test.yml`), seven rows from Ruby 2.7 / Rails 6.1 /
  Mongoid 7.5 / MongoDB 6.0 to Ruby 3.4 / Rails 8.0 / Mongoid 9.0 / MongoDB 8.0. The `Gemfile` selects
  Rails and Mongoid from `RAILS_VERSION` / `MONGOID_VERSION` (defaults 6.1 / 7.5).
- GitHub Release workflow (`.github/workflows/release.yml`): pushing a `vX.Y.Z` tag creates a GitHub Release
  with this file's section as the notes.

### Changed
- Runtime dependency `mongoid >= 7.0, < 10` (was any version).
- Specs run on RSpec 3.13 with `database_cleaner-mongoid` (was `database_cleaner`).
- The gemspec `homepage` points to this fork.
- README rewritten for the maintained fork (supported versions, generated methods, `require: 'arraylist'` in the
  Gemfile, known issues); history moved to this file.

### Removed
- Travis CI configuration and `.rvmrc`.

## [0.0.3] - 2018-06-01
### Added
- More specs for `list_field`, run against Mongoid 3–6 on Travis CI.

### Changed
- Items assigned through `<field>_list=` are no longer titlecased (`'tag1, tag2'` gives `["tag1", "tag2"]`, was
  `["Tag1", "Tag2"]`).
- Runtime dependency `mongoid` without a version constraint (was `~> 3.0`), so Mongoid 2 and 4–6 can be used.

### Fixed
- `<field>_list` returns `nil` instead of raising `NoMethodError` when the field is `nil`.

## [0.0.2] - 2013-06-04
### Changed
- Runtime dependency `mongoid ~> 3.0` (was `~> 3.0.0`).

## [0.0.1] - 2013-02-21
The v0.0.1 tag is on the initial commit, which set the version to 0.0.1; the 0.0.1 gem on RubyGems was built two
days later from c2c8616 (2013-02-23), which added the code below.
### Added
- Initial release by Ismail Dhorat: `include Mongoid::ArrayList` and `list_field :tags` define `tags_list` (the
  array joined with `", "`) and `tags_list=` (splits a string on `,`, strips and titlecases each item).

[Unreleased]: https://github.com/joe1chen/mongoid-arraylist/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/joe1chen/mongoid-arraylist/compare/v0.0.3...v0.1.0
[0.0.3]: https://github.com/joe1chen/mongoid-arraylist/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/joe1chen/mongoid-arraylist/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/joe1chen/mongoid-arraylist/releases/tag/v0.0.1
