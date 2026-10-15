import 'package:flutter/widgets.dart';
import 'animation_configurator.dart';

/// An animation that fades its child.
class FadeInAnimation extends StatelessWidget {
  /// The duration of the child animation.
  final Duration? duration;

  /// The delay between the beginning of two children's animations.
  final Duration? delay;

  /// The curve of the child animation. Defaults to [Curves.ease].
  final Curve curve;

  /// The child Widget to animate.
  final Widget child;

  /// Creates a fade animation that fades its child.
  ///
  /// The [child] argument must not be null.
  const FadeInAnimation({
    super.key,
    this.duration,
    this.delay,
    this.curve = Curves.ease,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationConfigurator(
      duration: duration,
      delay: delay,
      animatedChildBuilder: _fadeInAnimation,
    );
  }

  // FadeTransition updates the opacity layer directly instead of rebuilding
  // and repainting the child on every frame like an animated Opacity would.
  Widget _fadeInAnimation(Animation<double> animation) {
    return FadeTransition(
      opacity: animation.drive(CurveTween(curve: curve)),
      child: child,
    );
  }
}
