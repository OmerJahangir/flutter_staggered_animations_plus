import 'dart:async';

import 'package:flutter/widgets.dart';

import 'animation_limiter.dart';

/// Builder typedef for the animation executor.
typedef AnimationExecutorBuilder = Widget Function(
    BuildContext context, AnimationController? animationController);

/// Stateful widget that manages the [AnimationController] and executes
/// the animation with the configured duration and delay.
class AnimationExecutor extends StatefulWidget {
  /// The duration of the animation.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration delay;

  /// Builder function that creates the widget tree using the animation controller.
  final AnimationExecutorBuilder builder;

  const AnimationExecutor({
    super.key,
    required this.duration,
    this.delay = Duration.zero,
    required this.builder,
  });

  @override
  State<AnimationExecutor> createState() => _AnimationExecutorState();
}

class _AnimationExecutorState extends State<AnimationExecutor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(duration: widget.duration, vsync: this);

    if (AnimationLimiter.shouldRunAnimation(context) ?? true) {
      _timer = Timer(widget.delay, _animationController.forward);
    } else {
      _animationController.value = 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: _animationController,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return widget.builder(context, _animationController);
  }
}
