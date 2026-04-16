import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_staggered_animations_plus/flutter_staggered_animations_plus.dart';
import 'package:flutter/widgets.dart';

void main() {
  test('AnimationConfiguration.toStaggeredList returns correct number of items',
      () {
    final children = [
      const SizedBox(height: 10),
      const SizedBox(height: 20),
      const SizedBox(height: 30),
    ];

    final staggeredList = AnimationConfiguration.toStaggeredList(
      childAnimationBuilder: (widget) => FadeInAnimation(child: widget),
      children: children,
    );

    expect(staggeredList.length, 3);
  });

  test(
      'AnimationConfiguration.toStaggeredList wraps children in AnimationConfiguration',
      () {
    final children = [
      const SizedBox(height: 10),
    ];

    final staggeredList = AnimationConfiguration.toStaggeredList(
      childAnimationBuilder: (widget) => SlideAnimation(child: widget),
      children: children,
    );

    expect(staggeredList.first, isA<AnimationConfiguration>());
  });
}
