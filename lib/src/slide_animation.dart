import 'package:flutter/widgets.dart';

import 'animation_configurator.dart';

/// An animation that slides its child.
class SlideAnimation extends StatelessWidget {
  /// The duration of the child animation.
  final Duration? duration;

  /// The delay between the beginning of two children's animations.
  final Duration? delay;

  /// The curve of the child animation. Defaults to [Curves.ease].
  final Curve curve;

  /// The vertical offset to apply at the start of the animation (can be negative).
  final double verticalOffset;

  /// The horizontal offset to apply at the start of the animation (can be negative).
  final double horizontalOffset;

  /// The child Widget to animate.
  final Widget child;

  /// Creates a slide animation that slides its child from the given
  /// [verticalOffset] and [horizontalOffset] to its final position.
  ///
  /// A default value of 50.0 is applied to [verticalOffset] if
  /// [verticalOffset] and [horizontalOffset] are both undefined or null.
  ///
  /// The [child] argument must not be null.
  const SlideAnimation({
    super.key,
    this.duration,
    this.delay,
    this.curve = Curves.ease,
    double? verticalOffset,
    double? horizontalOffset,
    required this.child,
  })  : verticalOffset = (verticalOffset == null && horizontalOffset == null)
            ? 50.0
            : (verticalOffset ?? 0.0),
        horizontalOffset = horizontalOffset ?? 0.0;

  @override
  Widget build(BuildContext context) {
    return AnimationConfigurator(
      duration: duration,
      delay: delay,
      animatedChildBuilder: _slideAnimation,
    );
  }

  Widget _slideAnimation(Animation<double> animation) {
    final curved = animation.drive(CurveTween(curve: curve));

    double offsetValue(double offset) => offset == 0.0
        ? 0.0
        : Tween<double>(begin: offset, end: 0.0).transform(curved.value);

    return AnimatedBuilder(
      animation: curved,
      child: child,
      builder: (context, child) => Transform.translate(
        offset: Offset(
          offsetValue(horizontalOffset),
          offsetValue(verticalOffset),
        ),
        child: child,
      ),
    );
  }
}
