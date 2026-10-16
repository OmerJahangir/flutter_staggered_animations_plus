# flutter_staggered_animations_plus

Easily add staggered animations to your `ListView`, `GridView`, `Column` and `Row` children as shown in [Material Design guidelines](https://m2.material.io/design/motion/customization.html#sequencing).

A modernized fork of [flutter_staggered_animations](https://github.com/The-ring-io/flutter_staggered_animations) with **Dart 3+** and **Flutter 3.x** support.

## Features

- **Same API as the original** — switching over only needs a new import
- **Smooth on low-end devices** — no animation objects are created per frame, and your widgets are never rebuilt while animating
- **Works with any design system** — depends only on Flutter's widgets layer, so it works with `package:flutter/material.dart`, the standalone [`material_ui`](https://pub.dev/packages/material_ui) and [`cupertino_ui`](https://pub.dev/packages/cupertino_ui) packages, or no design system at all
- **All platforms** — Android, iOS, web (including WebAssembly), Windows, macOS and Linux
- **No dependencies** beyond the Flutter SDK
- Supports Flutter ≥3.10.0 and Dart ≥3.0.0, tested on the latest stable Flutter

## Showcase

| ListView                  | GridView                   | Column                       |
| ---                       | ---                        | ---                          |
|![](https://github.com/OmerJahangir/flutter_staggered_animations_plus/blob/main/assets/listview_demo.gif?raw=true)  | ![](https://github.com/OmerJahangir/flutter_staggered_animations_plus/blob/main/assets/gridview_demo.gif?raw=true)  | ![](https://github.com/OmerJahangir/flutter_staggered_animations_plus/blob/main/assets/column_demo.gif?raw=true)  |


## Getting Started

### Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_staggered_animations_plus: ^1.0.4
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
Every animation must have an `AnimationConfiguration` above it in the widget tree.


### AnimationConfiguration  

`AnimationConfiguration` is an `InheritedWidget` that shares its animation settings with its children (mainly duration and delay).

#### Named constructors

Depending on the scenario in which you will present your animations, you should use one of `AnimationConfiguration`'s named constructors. 

- `AnimationConfiguration.synchronized` if you want to launch all children's animations at the same time.
- `AnimationConfiguration.staggeredList` if you want to delay the animation of each child to produce a single-axis staggered animations (from top to bottom or from left to right).
- `AnimationConfiguration.staggeredGrid` if you want to delay the animation of each child to produce a dual-axis staggered animations (from left to right and top to bottom).

If you're not in the context of a `ListView` or `GridView`, an utility static method is available to help you apply staggered animations to the children of a `Row` or `Column`:

- `AnimationConfiguration.toStaggeredList`

> You can override `duration` and `delay` in each child Animation if needed.


## AnimationLimiter

Wrap your scrollable list with `AnimationLimiter` to prevent animations from running on items that have already appeared after the initial frame build. This ensures animations only play on items visible during the first render.

## Performance

The animations are built to stay smooth on older and low-spec devices:

- No animation objects are created per frame, so listeners never pile up on the animation controller.
- Your child widgets are built once and are never rebuilt while animating.
- `FadeInAnimation` uses `FadeTransition`, which updates opacity without rebuilding or repainting the child.
- `SlideAnimation`, `ScaleAnimation` and `FlipAnimation` rebuild only a single `Transform` per frame.

For the smoothest lists, wrap scrollable content in `AnimationLimiter` so items scrolled into view later don't animate.

## Migrating from flutter_staggered_animations

The public API is identical. Swap the dependency in `pubspec.yaml`:

```yaml
dependencies:
  flutter_staggered_animations_plus: ^1.0.4
```

Then update your imports:

```dart
// Before
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// After
import 'package:flutter_staggered_animations_plus/flutter_staggered_animations_plus.dart';
```

## Credits

Based on the original [flutter_staggered_animations](https://pub.dev/packages/flutter_staggered_animations) package by [mobiten](https://github.com/mobiten).

## License

MIT License — see [LICENSE](LICENSE) for details.
