# Stoa

A documentation theme for [Bridgetown](https://www.bridgetownrb.com), inspired by [just-the-docs](https://github.com/just-the-docs/just-the-docs).

## Status

**Pre-alpha.** Stoa is structural scaffolding only — gemspec, one minimal layout, a test harness. None of just-the-docs' features (sidebar nav, search, callouts, dark mode, anchor links) have been ported yet.

If you need a working docs theme for Bridgetown today, this isn't it yet.

## Installation

Add to your Bridgetown site's Gemfile:

```ruby
gem "bridgetown-stoa"
```

Then `bundle install` and add to `config/initializers.rb`:

```ruby
init :"bridgetown-stoa"
```

## Usage

One layout is registered: `bridgetown-stoa/layout`. Apply it via front matter:

```yaml
---
layout: bridgetown-stoa/layout
---
```

The layout chains into your site's `default` layout and yields the page content. No styling, navigation, or chrome — that's intentional for v0.1.

## Development

Requires Ruby ≥ 3.2 and Bridgetown ≥ 2.0.

```shell
bundle install
script/cibuild   # rubocop + minitest
```

Templates use [Serbea](https://www.bridgetownrb.com/docs/template-engines/erb-and-beyond), Bridgetown's ERB-with-Liquid-like-sugar engine. Stoa is **inspired by** just-the-docs, not a port of it — layouts are written idiomatically for Bridgetown rather than translated from upstream.

## License

MIT. See `LICENSE.txt`.
