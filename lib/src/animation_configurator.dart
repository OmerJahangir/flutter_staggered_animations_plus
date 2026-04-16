import 'package:flutter/widgets.dart';
import 'animation_configuration.dart';
import 'animation_executor.dart';

/// Internal widget that reads [AnimationConfiguration] from the widget tree
/// and creates an [AnimationExecutor] with the proper timing.
class AnimationConfigurator extends StatelessWidget {
  /// Optional duration override.
  final Duration? duration;

  /// Optional delay override.
  final Duration? delay;

  /// Builder that creates the animated child from the animation controller.
  final Widget Function(Animation<double>) animatedChildBuilder;

  const AnimationConfigurator({
    super.key,
    this.duration,
    this.delay,
    required this.animatedChildBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final animationConfiguration = AnimationConfiguration.of(context);

    if (animationConfiguration == null) {
      throw FlutterError.fromParts(
        <DiagnosticsNode>[
          ErrorSummary('Animation not wrapped in an AnimationConfiguration.'),
          ErrorDescription(
              'This error happens if you use an Animation that is not wrapped in an '
              'AnimationConfiguration.'),
          ErrorHint(
              'The solution is to wrap your Animation(s) with an AnimationConfiguration. '
              'Reminder: an AnimationConfiguration provides the configuration '
              'used as a base for every children Animation. Configuration made in AnimationConfiguration '
              'can be overridden in Animation children if needed.'),
        ],
      );
    }

    final position = animationConfiguration.position;
    final effectiveDuration = duration ?? animationConfiguration.duration;
    final effectiveDelay = delay ?? animationConfiguration.delay;
    final columnCount = animationConfiguration.columnCount;

    return AnimationExecutor(
      duration: effectiveDuration,
      delay: stagger(position, effectiveDuration, effectiveDelay, columnCount),
      builder: (context, animationController) =>
          animatedChildBuilder(animationController!),
    );
  }

  /// Computes the stagger delay for a given position.
  Duration stagger(
      int position, Duration duration, Duration? delay, int columnCount) {
    final delayInMilliseconds =
        delay == null ? duration.inMilliseconds ~/ 6 : delay.inMilliseconds;

    int computeStaggeredGridDuration() {
      return (position ~/ columnCount + position % columnCount) *
          delayInMilliseconds;
    }

    int computeStaggeredListDuration() {
      return position * delayInMilliseconds;
    }

    return Duration(
        milliseconds: columnCount > 1
            ? computeStaggeredGridDuration()
            : computeStaggeredListDuration());
  }
}
