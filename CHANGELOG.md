# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2024-08-09

### Added

- Added IS_SINGLEPLAYER constant.
- Added IS_COOP constant.

## [1.1.3] - 2024-08-07

### Changed

- Fixed mod structure.
- Some other unuseful stuff.

## [1.1.2] - 2024-07-06

### Added

-   Functions for representing the shared side of Lua.
-   Made the default logger mod id to `AoqiaBaseLogger`.

### Changed

-   Fixed a bug where the logger would use the static mod id instead of it's instance.
-   Fixed a bug where the logger would create a new instance without properly setting the mod id.

## [1.1.1] - 2024-07-02

### Changed

-   Fixed a bug where the logger would not set it's mod id.

## [1.1.0] - 2024-07-02

### Added

-   Made the logger act like class and not a module.

## [1.0.2] - 2024-06-24

### Added

-   Client/server constants.

## [1.0.1] - 2024-06-23

### Changed

-   Fixed logger module depending on deleted files.

## [1.0.0] - 2024-06-23

### Added

-   Official release.
