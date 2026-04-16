# flutter_staggered_animations_plus

Easily add staggered animations to your `ListView`, `GridView`, `Column` and `Row` children as shown in [Material Design guidelines](https://material.io/design/motion/customization.html#sequencing).

A modernized fork of [flutter_staggered_animations](https://github.com/The-ring-io/flutter_staggered_animations) with **Dart 3+** and **Flutter 3.x** support.

## Getting Started

### Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_staggered_animations_plus: ^1.0.0
```

Then run:

```bash
flutter pub get
```

### Import

```dart
import 'package:flutter_staggered_animations_plus/flutter_staggered_animations_plus.dart';
```

## Usage

### ListView

```dart
AnimationLimiter(
  child: ListView.builder(
    itemCount: 100,
    itemBuilder: (BuildContext context, int index) {
      return AnimationConfiguration.staggeredList(
        position: index,
        duration: const Duration(milliseconds: 375),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: YourListChild(),
          ),
        ),
      );
    },
  ),
);
```

### GridView

```dart
AnimationLimiter(
  child: GridView.count(
    crossAxisCount: 2,
    children: List.generate(100, (int index) {
      return AnimationConfiguration.staggeredGrid(
        position: index,
        duration: const Duration(milliseconds: 375),
        columnCount: 2,
        child: ScaleAnimation(
          child: FadeInAnimation(
            child: YourGridChild(),
          ),
        ),
      );
    }),
  ),
);
```

### Column / Row

```dart
Column(
  children: AnimationConfiguration.toStaggeredList(
    duration: const Duration(milliseconds: 375),
    childAnimationBuilder: (widget) => SlideAnimation(
      horizontalOffset: 50.0,
      child: FadeInAnimation(
        child: widget,
      ),
    ),
    children: yourChildren,
  ),
);
```

## Available Animations

| Animation | Description |
|-----------|-------------|
| `FadeInAnimation` | Fades a child in (opacity 0 → 1) |
| `SlideAnimation` | Slides a child from a given offset to its final position |
| `ScaleAnimation` | Scales a child from a given scale to 1.0 |
| `FlipAnimation` | Flips a child along the X or Y axis |

## Combining Animations

You can nest multiple animations to create compound effects:

```dart
SlideAnimation(
  verticalOffset: 50.0,
  child: FadeInAnimation(
    child: ScaleAnimation(
      child: YourWidget(),
    ),
  ),
)
```

## AnimationLimiter

Wrap your scrollable list with `AnimationLimiter` to prevent animations from running on items that have already appeared after the initial frame build. This ensures animations only play on items visible during the first render.

## Credits

Based on the original [flutter_staggered_animations](https://pub.dev/packages/flutter_staggered_animations) package by [mobiten](https://github.com/mobiten).

## License

MIT License — see [LICENSE](LICENSE) for details.
