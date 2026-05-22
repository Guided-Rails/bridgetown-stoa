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
title: My Page
---
```

The layout is self-contained: it renders a full HTML document (doctype, `<head>` with title and asset tags, semantic `<header>`/`<main>`/`<footer>` regions) and yields the page body into `<main>`. You do **not** need a `default` layout in your site to use Stoa.

The document title is `{page title} | {site metadata title}` when a page sets `title:` in front matter, and just the site title otherwise. The layout also injects `asset_path :css` / `:js` so your site's esbuild bundle loads automatically.

### Overriding the layout

To customize the chrome, shadow the layout in your own site:

```
src/_layouts/bridgetown-stoa/layout.serb
```

Bridgetown's layout resolution picks the host site's file over the gem's, so you can replace the entire layout or copy ours and edit it. (More granular override points — head, nav, footer partials — will land as the theme grows.)

## Development

Requires Ruby ≥ 3.2 and Bridgetown ≥ 2.0.

```shell
bundle install
script/cibuild   # rubocop + minitest
```

Templates use [Serbea](https://www.bridgetownrb.com/docs/template-engines/erb-and-beyond), Bridgetown's ERB-with-Liquid-like-sugar engine. Stoa is **inspired by** just-the-docs, not a port of it — layouts are written idiomatically for Bridgetown rather than translated from upstream.

## License

MIT. See `LICENSE.txt`.
