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

### Styles (Tailwind v4)

Stoa ships its styles as a Tailwind v4 source partial in a companion npm package, so they compose with your site's Tailwind pipeline (tree-shaken, token-overrideable).

```shell
npm install bridgetown-stoa
```

Then in `frontend/styles/index.css`, after `@import "tailwindcss";`, add two lines:

```css
@import "tailwindcss";
@source "../../node_modules/bridgetown-stoa/layouts/**/*.serb";
@import "bridgetown-stoa";
```

- `@source` tells Tailwind to scan Stoa's layouts for utility-class usage.
- `@import "bridgetown-stoa"` pulls in the `@theme` tokens (`--color-stoa-*`, `--font-stoa-*`) and a small `@layer base` that styles `html` with the theme colors.

Override any token by redeclaring it in your own `@theme` block after the import.

Stoa uses Tailwind's **class-strategy dark mode** (`html.dark`). Toggle the `dark` class on `<html>` to switch themes; a default JS toggle that follows `prefers-color-scheme` will ship in a later release.

> **Note:** the `bridgetown-stoa` npm package is not yet published — install will fail until the first release. The Tailwind setup docs above describe the intended UX. Track [the publish task](https://github.com/Guided-Rails/bridgetown-stoa/issues) for progress.

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
