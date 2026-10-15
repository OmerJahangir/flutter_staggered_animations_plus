import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations_plus/flutter_staggered_animations_plus.dart';
import 'package:flutter_test/flutter_test.dart';

const _boxKey = ValueKey('box');

Widget _wrap(Widget child) => Directionality(
      textDirection: TextDirection.ltr,
      child: Center(child: child),
    );

Widget _box([Key key = _boxKey]) => SizedBox(key: key, width: 50, height: 50);

double _opacityOf(WidgetTester tester, Finder finder) {
  var opacity = 1.0;
  RenderObject? node = tester.renderObject(finder).parent;
  while (node != null) {
    if (node is RenderAnimatedOpacity) opacity *= node.opacity.value;
    if (node is RenderOpacity) opacity *= node.opacity;
    node = node.parent;
  }
  return opacity;
}

Offset _topLeftOf(WidgetTester tester, Finder finder) =>
    tester.getTopLeft(finder);

void main() {
  group('animations run from their start values to the identity', () {
    testWidgets('FadeInAnimation', (tester) async {
      await tester.pumpWidget(_wrap(AnimationConfiguration.synchronized(
        child: FadeInAnimation(child: _box()),
      )));
      expect(_opacityOf(tester, find.byKey(_boxKey)), 0.0);

      await tester.pumpAndSettle();
      expect(_opacityOf(tester, find.byKey(_boxKey)), 1.0);
    });

    testWidgets('SlideAnimation', (tester) async {
      await tester.pumpWidget(_wrap(_box()));
      final restingPosition = _topLeftOf(tester, find.byKey(_boxKey));

      await tester.pumpWidget(_wrap(AnimationConfiguration.synchronized(
        child: SlideAnimation(
          verticalOffset: 40,
          horizontalOffset: -20,
          child: _box(),
        ),
      )));
      expect(
        _topLeftOf(tester, find.byKey(_boxKey)),
        restingPosition + const Offset(-20, 40),
      );

      await tester.pumpAndSettle();
      expect(_topLeftOf(tester, find.byKey(_boxKey)), restingPosition);
    });

    testWidgets('ScaleAnimation', (tester) async {
      await tester.pumpWidget(_wrap(AnimationConfiguration.synchronized(
        child: ScaleAnimation(scale: 0.5, child: _box()),
      )));
      expect(tester.getSize(find.byKey(_boxKey)), const Size(50, 50));
      expect(
        tester.getRect(find.byKey(_boxKey)).width,
        moreOrLessEquals(25),
      );

      await tester.pumpAndSettle();
      expect(
        tester.getRect(find.byKey(_boxKey)).width,
        moreOrLessEquals(50),
      );
    });

    testWidgets('FlipAnimation', (tester) async {
      await tester.pumpWidget(_wrap(AnimationConfiguration.synchronized(
        child: FlipAnimation(flipAxis: FlipAxis.y, child: _box()),
      )));
      expect(
        tester.getRect(find.byKey(_boxKey)).width,
        moreOrLessEquals(0, epsilon: 1e-6),
      );

      await tester.pumpAndSettle();
      expect(
        tester.getRect(find.byKey(_boxKey)).width,
        moreOrLessEquals(50),
      );
    });
  });

  testWidgets('staggeredList delays each child by its position',
      (tester) async {
    await tester.pumpWidget(_wrap(Column(
      children: AnimationConfiguration.toStaggeredList(
        duration: const Duration(milliseconds: 300),
        childAnimationBuilder: (child) => FadeInAnimation(child: child),
        children: [_box(const ValueKey(0)), _box(const ValueKey(1))],
      ),
    )));

    // Default delay is duration / 6 = 50ms, so the second child starts later.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 20));
    await tester.pump(const Duration(milliseconds: 20));
    expect(_opacityOf(tester, find.byKey(const ValueKey(0))), greaterThan(0));
    expect(_opacityOf(tester, find.byKey(const ValueKey(1))), 0.0);

    await tester.pumpAndSettle();
    expect(_opacityOf(tester, find.byKey(const ValueKey(1))), 1.0);
  });

  testWidgets('AnimationLimiter skips children built after the first frame',
      (tester) async {
    var showSecond = false;
    late StateSetter setState;

    await tester.pumpWidget(_wrap(AnimationLimiter(
      child: StatefulBuilder(builder: (context, setter) {
        setState = setter;
        return Column(children: [
          for (var i = 0; i < (showSecond ? 2 : 1); i++)
            AnimationConfiguration.staggeredList(
              position: i,
              child: FadeInAnimation(child: _box(ValueKey(i))),
            ),
        ]);
      }),
    )));
    expect(_opacityOf(tester, find.byKey(const ValueKey(0))), 0.0);
    await tester.pumpAndSettle();

    setState(() => showSecond = true);
    await tester.pump();
    expect(_opacityOf(tester, find.byKey(const ValueKey(1))), 1.0);
  });

  testWidgets('does not create CurvedAnimation objects while animating',
      (tester) async {
    var created = 0;
    void listener(ObjectEvent event) {
      if (event is ObjectCreated && event.object is CurvedAnimation) created++;
    }

    FlutterMemoryAllocations.instance.addListener(listener);
    addTearDown(
        () => FlutterMemoryAllocations.instance.removeListener(listener));

    await tester.pumpWidget(_wrap(AnimationConfiguration.synchronized(
      child: SlideAnimation(
        child: FadeInAnimation(
          child: ScaleAnimation(child: FlipAnimation(child: _box())),
        ),
      ),
    )));
    await tester.pumpAndSettle();

    expect(created, 0);
  });

  testWidgets('throws a helpful error without an AnimationConfiguration',
      (tester) async {
    await tester.pumpWidget(_wrap(FadeInAnimation(child: _box())));
    expect(
      tester.takeException(),
      isA<FlutterError>().having(
        (e) => e.message,
        'message',
        contains('Animation not wrapped in an AnimationConfiguration'),
      ),
    );
  });
}
