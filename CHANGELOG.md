# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Enabled the `yarn-add` gemspec metadata so Bridgetown sites that install the gem auto-add the `bridgetown-stoa` npm dependency. Matches the idiomatic pattern from `bridgetown-quick-search`. (`yarn-add` and `npm_add` are synonyms inside Bridgetown's plugin manager — the gemspec template's commented `npm_add` is the older name; the ecosystem has standardized on `yarn-add`.)
- Excluded `frontend/` from the gem's `files` glob. The Tailwind partial belongs in the npm companion only; shipping it in the gem too was duplicate distribution.
- Test fixture initializer now passes `require_gem: false` to `init :"bridgetown-stoa"` so Bridgetown's plugin manager doesn't run `install_npm_dependencies` during the test suite (which would inject a self-referencing dep into the gem's own `package.json`). The gem is already loaded by `test/helper.rb`, so the re-require was redundant anyway.

## [0.2.0] - 2026-05-22

### Added
- Tailwind v4 source partial at `frontend/styles/bridgetown-stoa.css`, shipped via a companion `bridgetown-stoa` npm package. Defines `--color-stoa-*` and `--font-stoa-*` design tokens (light + dark) in an `@theme` block, sets up class-strategy dark mode via `@custom-variant dark`, and applies a baseline `html` style. Host sites `@import "bridgetown-stoa"` and `@source` the layouts from their `frontend/styles/index.css`.
- `script/release` now also runs `npm publish` after the gem release, and pre-flights `npm whoami` so it bails before the gem push if credentials are missing.

### Fixed
- `bridgetown-stoa/layout` no longer prepends `"Index | "` to `<title>` on the home page when `src/index.md` has no explicit `title:` front-matter. (#8)

## [0.1.0] - 2026-05-22

### Changed
- `bridgetown-stoa/layout` is now a self-contained HTML document (doctype, `<head>` with title/meta/asset tags, and `<header>`/`<main>`/`<footer>` chrome). Consumers no longer need to provide their own `default` layout to use Stoa. The layout also prepends `resource.data.title` to `<title>` when set. (#5)

### Notes
- The layout wires `asset_path :css` / `:js` for the host site's esbuild bundle. Bridgetown sites created with `bridgetown new` ship esbuild by default; sites without frontend bundling will see `MISSING_FRONTEND_BUNDLING_CONFIG` in the asset URLs until they configure one (or shadow the layout to drop the tags).

## [0.0.2] - 2026-05-22

### Fixed
- `init :"bridgetown-stoa"` no longer raises `NameError: uninitialized constant BridgetownStoa` (#2)

## [0.0.1] - 2026-05-20

- Initial scaffold
