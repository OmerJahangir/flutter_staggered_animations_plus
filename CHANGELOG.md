# Changelog

## 1.0.4

Performance improvements for smoother animations on low-end devices. Animations look exactly the same.

- Fixed a leak where every animation created a new `CurvedAnimation` on each frame and never disposed it, so listeners piled up on the controller
- Animation widgets no longer rebuild on every frame: `FadeInAnimation` now uses `FadeTransition`, and slide, scale and flip rebuild only their `Transform`
- Configuration lookups use `getInheritedWidgetOfExactType` (constant time) instead of walking up the widget tree
- Added widget tests covering every animation, staggering, `AnimationLimiter` and the leak fix
- README: added Features, Performance and migration sections, and fixed the Material Design link
- Added pub.dev topics

## 1.0.3

- Fixed Flutter constraint to `>=3.10.0` (the first Flutter release shipping Dart 3.0)
- Verified with the latest stable Flutter 3.47 / Dart 3.13
- Excluded build and platform directories from analysis
- Migrated the example app to the standalone `material_ui` package
- Updated the example Android build to AGP 9.1, Kotlin 2.4 and Gradle 9.3.1
- Refreshed example dependencies

## 1.0.2

- Changed the minimum sdk version to 3.0.0 support older projects

## 1.0.1

- made changes in README.md file 
- changed path to show gifs

## 1.0.0

- Initial release — modernized fork of `flutter_staggered_animations` v1.1.1
- Updated SDK constraint to Dart 3+ (`>=3.0.0 <4.0.0`)
- Migrated all constructors to use `super.key` / `super.child` syntax
- Removed deprecated leading underscore on local variables
- Removed unreachable `default` case in exhaustive enum switch (Dart 3 pattern)
- Renamed `Builder` typedef to `AnimationExecutorBuilder` to avoid conflicts
- Added support for all platforms (android, ios, linux, macos, web, windows)
- Updated documentation and added comprehensive README
