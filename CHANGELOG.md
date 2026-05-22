# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
