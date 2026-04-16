# Changelog

## 1.0.0

- Initial release — modernized fork of `flutter_staggered_animations` v1.1.1
- Updated SDK constraint to Dart 3+ (`>=3.0.0 <4.0.0`)
- Migrated all constructors to use `super.key` / `super.child` syntax
- Removed deprecated leading underscore on local variables
- Removed unreachable `default` case in exhaustive enum switch (Dart 3 pattern)
- Renamed `Builder` typedef to `AnimationExecutorBuilder` to avoid conflicts
- Added support for all platforms (android, ios, linux, macos, web, windows)
- Updated documentation and added comprehensive README
